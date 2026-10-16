defmodule PhoenixMultivitaminWeb.LinkopingGripenTraysLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.LinkopingGripenTraysLive

  @path "/features/04-function-components-and-heex/11-linkoping-gripen-trays"

  test "a listed mark renders and values: does not reject a dynamic naval assign", %{
    conn: conn
  } do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Saab · Linköping"
    assert html =~ "Liv"
    assert has_element?(view, "#gripen-tray [data-field=mark]", ":c")
    assert has_element?(view, "#gripen-tray [data-field=rivets]", "4800")

    html = view |> element("#load-naval") |> render_click()
    assert html =~ "unlisted naval"
    assert has_element?(view, "#gripen-tray [data-field=mark]", ":naval")

    view |> element("#load-d") |> render_click()
    assert has_element?(view, "#gripen-tray", "Gripen mark D")
  end

  test "a missing required attr on a direct call is a KeyError, not an attr/3 raise" do
    assert_raise KeyError, fn ->
      render_component(&LinkopingGripenTraysLive.mark_tray/1, %{
        id: "bare-tray",
        bay: "B-1"
      })
    end
  end

  test "rivets default is applied on a direct call that omits it" do
    html =
      render_component(&LinkopingGripenTraysLive.mark_tray/1, %{
        id: "direct-tray",
        mark: :e,
        bay: "C-4"
      })

    assert html =~ "Gripen mark E"
    assert html =~ "4800"
  end
end

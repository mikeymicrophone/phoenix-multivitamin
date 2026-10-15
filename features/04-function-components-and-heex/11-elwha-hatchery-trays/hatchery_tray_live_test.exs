defmodule PhoenixMultivitaminWeb.ElwhaHatcheryTraysLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.ElwhaHatcheryTraysLive

  @path "/features/04-function-components-and-heex/11-elwha-hatchery-trays"

  test "a listed species renders and values: does not reject a dynamic chum assign", %{
    conn: conn
  } do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Lower Elwha Hatchery"
    assert html =~ "Leni"
    assert has_element?(view, "#heath-tray [data-field=species]", ":chinook")
    assert has_element?(view, "#heath-tray [data-field=eggs]", "4800")

    html = view |> element("#load-chum") |> render_click()
    assert html =~ "unlisted chum"
    assert has_element?(view, "#heath-tray [data-field=species]", ":chum")

    view |> element("#load-coho") |> render_click()
    assert has_element?(view, "#heath-tray", "Elwha coho")
  end

  test "a missing required attr on a direct call is a KeyError, not an attr/3 raise" do
    assert_raise KeyError, fn ->
      render_component(&ElwhaHatcheryTraysLive.incubation_tray/1, %{
        id: "bare-tray",
        pond: "B-1"
      })
    end
  end

  test "eggs default is applied on a direct call that omits it" do
    html =
      render_component(&ElwhaHatcheryTraysLive.incubation_tray/1, %{
        id: "direct-tray",
        species: :steelhead,
        pond: "C-4"
      })

    assert html =~ "Elwha steelhead"
    assert html =~ "4800"
  end
end

defmodule PhoenixMultivitaminWeb.LongyearbyenPolarCardsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/13-longyearbyen-polar-cards"

  test "on-stand panels render with yielded notes, pass chips, and rest attrs", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Longyearbyen apron"
    assert html =~ "Toril"
    assert has_element?(view, "#panel-a-note", "A at stand 12")
    assert has_element?(view, "#panel-a-inbound", "inbound 4")
    assert has_element?(view, "#panel-a-outbound", "outbound 11")
    refute has_element?(view, "#panel-a-tech")
    assert has_element?(view, "#panel-a-watch", "Toril on the apron")
    assert has_element?(view, "#panel-b-watch", "No night ops posted.")
    refute has_element?(view, "#panel-c")
    assert html =~ ~s(data-crest="stand 12")
  end

  test "packed ice adds a class, and lifting stand B drops its card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    class = view |> element("#panel-a") |> render()
    refute class =~ "mount-banner"

    view |> element("#pack-ice") |> render_click()
    assert view |> element("#panel-a") |> render() =~ "mount-banner"

    view |> element("#lift-stand-b") |> render_click()
    refute has_element?(view, "#panel-b")
    assert has_element?(view, "#panel-a")
  end
end

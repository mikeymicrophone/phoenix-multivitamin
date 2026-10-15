defmodule PhoenixMultivitaminWeb.SkokomishWeirCardsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/13-skokomish-weir-cards"

  test "in-water panels render with yielded notes, pass chips, and rest attrs", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Skokomish River weir"
    assert html =~ "Elsie"
    assert has_element?(view, "#panel-a-note", "A at 12 in")
    assert has_element?(view, "#panel-a-chinook", "chinook 4")
    assert has_element?(view, "#panel-a-coho", "coho 11")
    refute has_element?(view, "#panel-a-pink")
    assert has_element?(view, "#panel-a-watch", "Elsie on the catwalk")
    assert has_element?(view, "#panel-b-watch", "No night watch posted.")
    refute has_element?(view, "#panel-c")
    assert html =~ ~s(data-crest="12 in")
  end

  test "flood stage adds a class, and lifting panel B drops its card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    class = view |> element("#panel-a") |> render()
    refute class =~ "mount-banner"

    view |> element("#rise-to-flood") |> render_click()
    assert view |> element("#panel-a") |> render() =~ "mount-banner"

    view |> element("#lift-panel-b") |> render_click()
    refute has_element?(view, "#panel-b")
    assert has_element?(view, "#panel-a")
  end
end

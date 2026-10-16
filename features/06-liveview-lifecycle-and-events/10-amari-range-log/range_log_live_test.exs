defmodule PhoenixMultivitaminWeb.AmariRangeLogLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/10-amari-range-log"

  test "the click HTML includes the temporary sighting, then the assign resets", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Ämari Air Base"
    assert has_element?(view, "#controller-name", "Katrin")
    assert has_element?(view, "#last-sighting", "none")
    assert has_element?(view, "#sighting-readback", "none")

    click_html = view |> element("#log-front-range") |> render_click()

    assert click_html =~ "Front range on the Ämari scaffold"
    assert has_element?(view, "#last-sighting", "Front range on the Ämari scaffold")
    assert has_element?(view, "#posted-bearings", "Front range on the Ämari scaffold")
    assert has_element?(view, "#bearing-count", "1")

    view |> element("#confirm-last-sighting") |> render_click()

    assert has_element?(view, "#sighting-readback", "cleared")
    assert has_element?(view, "#last-sighting", "Front range on the Ämari scaffold")
    assert has_element?(view, "#posted-bearings", "Front range on the Ämari scaffold")
  end

  test "a later event that skips last_sighting leaves the old DOM node in place", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#log-rear-range") |> render_click()
    assert has_element?(view, "#last-sighting", "Rear range on the bluff")

    view |> element("#log-go-around") |> render_click()

    assert has_element?(view, "#last-sighting", "Rear range on the bluff")
    assert has_element?(view, "#last-event", "go_around")
    assert has_element?(view, "#posted-bearings", "Rear range on the bluff")
    assert has_element?(view, "#posted-bearings", "C-17 go-around over the threshold")
    assert has_element?(view, "#bearing-count", "2")

    view |> element("#confirm-last-sighting") |> render_click()
    assert has_element?(view, "#sighting-readback", "cleared")
  end
end

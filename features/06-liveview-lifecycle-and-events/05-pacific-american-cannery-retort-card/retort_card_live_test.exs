defmodule PhoenixMultivitaminWeb.PacificAmericanCanneryRetortCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/05-pacific-american-cannery-retort-card"

  test "phx-blur posts the temperature when the cook leaves the field", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Pacific American Fisheries"
    assert has_element?(view, "#cook-name", "Inez")
    assert has_element?(view, "#vent-state", "open")
    assert has_element?(view, "#empty-card")

    view
    |> element("#temperature-field")
    |> render_blur(%{"value" => "242"})

    assert has_element?(view, "#temperature-f", "242")
    assert has_element?(view, "#last-blur", "temperature")
    assert has_element?(view, "#card-lines", "242°F in Retort 3, at process")
    refute has_element?(view, "#empty-card")
  end

  test "a coming-up temperature and a later cook-time blur stack on the card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#temperature-field")
    |> render_blur(%{"value" => "180"})

    view
    |> element("#cook-minutes-field")
    |> render_blur(%{"value" => "90"})

    assert has_element?(view, "#temperature-f", "180")
    assert has_element?(view, "#cook-minutes", "90")
    assert has_element?(view, "#last-blur", "cook_minutes")
    assert has_element?(view, "#card-lines", "still coming up")
    assert has_element?(view, "#card-lines", "90 minute cook marked")
  end

  test "closing the vent is a click, not a blur", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#close-vent") |> render_click()

    assert has_element?(view, "#vent-state", "closed")
    assert has_element?(view, "#card-lines", "Vent closed on Retort 3")
    assert has_element?(view, "#last-blur", "none")
  end
end

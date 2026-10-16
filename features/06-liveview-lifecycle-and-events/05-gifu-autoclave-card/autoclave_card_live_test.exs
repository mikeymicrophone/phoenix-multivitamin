defmodule PhoenixMultivitaminWeb.GifuAutoclaveCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/05-gifu-autoclave-card"

  test "phx-blur posts the temperature when the tech leaves the field", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Kawasaki Gifu Works"
    assert has_element?(view, "#tech-name", "Yuto")
    assert has_element?(view, "#vent-state", "open")
    assert has_element?(view, "#empty-card")

    view
    |> element("#temperature-field")
    |> render_blur(%{"value" => "242"})

    assert has_element?(view, "#temperature-f", "242")
    assert has_element?(view, "#last-blur", "temperature")
    assert has_element?(view, "#card-lines", "242°F in Autoclave 3, at process")
    refute has_element?(view, "#empty-card")
  end

  test "a coming-up temperature and a later cure-time blur stack on the card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#temperature-field")
    |> render_blur(%{"value" => "180"})

    view
    |> element("#cure-minutes-field")
    |> render_blur(%{"value" => "90"})

    assert has_element?(view, "#temperature-f", "180")
    assert has_element?(view, "#cure-minutes", "90")
    assert has_element?(view, "#last-blur", "cure_minutes")
    assert has_element?(view, "#card-lines", "still coming up")
    assert has_element?(view, "#card-lines", "90 minute cure marked")
  end

  test "closing the vent is a click, not a blur", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#close-vent") |> render_click()

    assert has_element?(view, "#vent-state", "closed")
    assert has_element?(view, "#card-lines", "Vent closed on Autoclave 3")
    assert has_element?(view, "#last-blur", "none")
  end
end

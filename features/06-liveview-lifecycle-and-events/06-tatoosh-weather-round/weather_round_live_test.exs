defmodule PhoenixMultivitaminWeb.TatooshWeatherRoundLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/06-tatoosh-weather-round"

  test "a matching key posts the wind observation", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Tatoosh Island"
    assert has_element?(view, "#observer-name", "Quill")

    view
    |> element("#wind-pad")
    |> render_keydown(%{"key" => "w"})

    assert has_element?(view, "#last-key", "w")
    assert has_element?(view, "#last-binding", "wind")
    assert has_element?(view, "#observations", "West-northwest 28 knots")
  end

  test "LiveViewTest sends a mismatched key that phx-key would have dropped", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#fog-pad")
    |> render_keydown(%{"key" => "x"})

    assert has_element?(view, "#last-key", "x")
    assert has_element?(view, "#last-binding", "note_fog")
    assert has_element?(view, "#observations", "Stray key \"x\" reached note_fog")
  end

  test "Enter posts the round from the enter pad", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#enter-pad")
    |> render_keydown(%{"key" => "Enter"})

    assert has_element?(view, "#last-key", "Enter")
    assert has_element?(view, "#last-binding", "enter")
    assert has_element?(view, "#observations", "Weather round posted")
  end
end

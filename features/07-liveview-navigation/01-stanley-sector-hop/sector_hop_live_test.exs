defmodule PhoenixMultivitaminWeb.StanleySectorHopLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/01-stanley-sector-hop"

  test "a patch reuses the process and handle_params swaps the sector", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Kezia")
    assert has_element?(view, "#sector-name", "East sector")
    assert has_element?(view, "#mount-count", "1")

    view |> element("#hop-west") |> render_click()
    assert_patch(view, @path <> "?sector=west")
    assert has_element?(view, "#sector-name", "West sector")
    assert has_element?(view, "#sector-wind", "25022KT")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#hop-count", "1")
  end
end

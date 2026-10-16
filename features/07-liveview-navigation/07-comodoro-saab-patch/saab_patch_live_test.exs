defmodule PhoenixMultivitaminWeb.ComodoroSaabPatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/07-comodoro-saab-patch"

  test "an event push_patch bumps the gust and swaps the pad", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Facundo")
    assert has_element?(view, "#pad-name", "north")

    view |> element("#gust-south") |> render_click()
    assert_patch(view, @path <> "?pad=south")
    assert has_element?(view, "#pad-name", "south")
    assert has_element?(view, "#gust-count", "1")
    assert has_element?(view, "#craft-name", "Saab 340")
  end
end

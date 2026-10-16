defmodule PhoenixMultivitaminWeb.InuvikMapRowsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/06-inuvik-map-rows"

  test "dom_id uses the METAR hour on a map row", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Qajaq")
    assert has_element?(view, "#metar-18z", "18z")

    view |> element("#add-21z") |> render_click()
    assert has_element?(view, "#metar-21z", "21z")
  end
end

defmodule PhoenixMultivitaminWeb.BerberaEventCellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/03-berbera-event-cell"

  test "the park click stays in the cell", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-stand", "none")
    assert has_element?(view, "#parent-stand", "quiet")

    view |> element("#park-south") |> render_click()
    assert has_element?(view, "#cell-stand", "south")
    assert has_element?(view, "#parent-stand", "quiet")
  end
end

defmodule PhoenixMultivitaminWeb.KaragandaSendUpdateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/08-karaganda-send-update"

  test "send_update/3 lifts the cell QNH without the parent assign", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-qnh", "1012")
    assert has_element?(view, "#parent-qnh", "1012")

    view |> element("#lift-qnh") |> render_click()
    assert has_element?(view, "#cell-qnh", "1024")
    assert has_element?(view, "#parent-qnh", "1012")
  end
end

defmodule PhoenixMultivitaminWeb.BodoSurviveCellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/12-bodo-survive-cell"

  test "the cell keeps one mount across parent ticks", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-mounts", "1")

    view |> element("#tick-parent") |> render_click()
    assert has_element?(view, "#parent-ticks", "1")
    assert has_element?(view, "#cell-mounts", "1")
  end
end

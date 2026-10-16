defmodule PhoenixMultivitaminWeb.NorilskHoistExitLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/11-norilsk-hoist-exit"

  test "an exiting async process fails the hoist without killing the LiveView", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "Gavril"
    assert html =~ "hoist_cable_snap"
    assert has_element?(view, "#hoist-failed", "hoist_cable_snap")
    assert has_element?(view, "#clerk-name", "Gavril")
    assert has_element?(view, "#craft-name", "Mil Mi-26")
    refute has_element?(view, "#hoist-loading")
  end
end

defmodule PhoenixMultivitaminWeb.NorilskHoistExitLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/11-norilsk-hoist-exit"

  test "an exit from the async process takes down the LiveView", %{conn: conn} do
    html = html_response(get(conn, @path), 200)
    assert html =~ "Norilsk hoist exit"
    assert html =~ "Gavril"
    assert html =~ "Mil Mi-26"

    assert catch_exit(live(conn, @path)) == :hoist_cable_snap
  end
end

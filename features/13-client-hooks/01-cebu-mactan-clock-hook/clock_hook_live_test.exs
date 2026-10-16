defmodule PhoenixMultivitaminWeb.CebuMactanClockHookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/01-cebu-mactan-clock-hook"

  test "both departure clocks declare their zones and hook ownership", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Luningning")
    assert has_element?(view, "#mactan-clock[phx-hook$='.DispatchClock'][phx-update='ignore'][data-zone='Asia/Manila'] time")
    assert has_element?(view, "#utc-clock[phx-hook$='.DispatchClock'][data-zone='UTC'] time")
  end
end

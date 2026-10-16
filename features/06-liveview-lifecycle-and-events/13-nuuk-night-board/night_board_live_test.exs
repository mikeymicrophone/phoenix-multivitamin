defmodule PhoenixMultivitaminWeb.NuukNightBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.NuukDepartureDesk

  @path "/features/06-liveview-lifecycle-and-events/13-nuuk-night-board"

  setup do
    start_supervised!(NuukDepartureDesk)
    :ok
  end

  test "the disconnected render does not spawn a process, so terminate/2 does not run", %{
    conn: conn
  } do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Nuuk Airport"
    assert html =~ "Static mount. No LiveView process, so terminate/2 will not run."
    assert html =~ "Naja"
    assert NuukDepartureDesk.departures() == []
  end

  test "the connected board arms the clock, posts traffic, and patches the watch", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Socket connected. The night board clock is armed."
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#clock-armed", "armed")
    assert has_element?(view, "#controller-name", "Naja")
    assert has_element?(view, "#tick-count", "1")
    assert has_element?(view, "#traffic-lines", "Board clock ticked")

    view |> element("#log-inbound-greenland") |> render_click()
    assert has_element?(view, "#traffic-lines", "Air Greenland 208 inbound")

    view |> element("#log-outbound-dash") |> render_click()
    assert has_element?(view, "#traffic-lines", "Dash 8-200 outbound")

    view |> element("#midwatch") |> render_click()
    assert_patch(view, @path <> "?watch=mid")
    assert has_element?(view, "#controller-name", "Malik")
    assert has_element?(view, "#watch-name", "Midwatch")
    assert has_element?(view, "#station-clock", "00:00")
  end

  test "stopping the connected LiveView records a departure in terminate/2", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    _ = :sys.get_state(view.pid)

    lv_pid = view.pid
    ref = Process.monitor(lv_pid)
    GenServer.stop(lv_pid, :shutdown)
    assert_receive {:DOWN, ^ref, :process, ^lv_pid, :shutdown}

    [departure] = NuukDepartureDesk.departures()
    assert departure.controller == "Naja"
    assert departure.watch == "First watch"
    assert departure.connected_mount? == true
    assert departure.reason == :shutdown
  end
end

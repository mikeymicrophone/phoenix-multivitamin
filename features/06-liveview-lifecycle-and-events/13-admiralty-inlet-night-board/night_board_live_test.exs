defmodule PhoenixMultivitaminWeb.AdmiraltyInletNightBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.AdmiraltyInletDepartureDesk

  @path "/features/06-liveview-lifecycle-and-events/13-admiralty-inlet-night-board"

  setup do
    start_supervised!(AdmiraltyInletDepartureDesk)
    :ok
  end

  test "the disconnected render does not spawn a process, so terminate/2 does not run", %{
    conn: conn
  } do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Puget Sound Pilot Station"
    assert html =~ "Static mount. No LiveView process, so terminate/2 will not run."
    assert html =~ "Corin"
    assert AdmiraltyInletDepartureDesk.departures() == []
  end

  test "the connected board arms the clock, posts traffic, and patches the watch", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Socket connected. The night board clock is armed."
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#clock-armed", "armed")
    assert has_element?(view, "#dispatcher-name", "Corin")
    assert has_element?(view, "#tick-count", "1")
    assert has_element?(view, "#traffic-lines", "Board clock ticked")

    view |> element("#log-inbound-evergreen") |> render_click()
    assert has_element?(view, "#traffic-lines", "Evergreen State inbound")

    view |> element("#log-outbound-hyak") |> render_click()
    assert has_element?(view, "#traffic-lines", "Hyak outbound")

    view |> element("#midwatch") |> render_click()
    assert_patch(view, @path <> "?watch=mid")
    assert has_element?(view, "#dispatcher-name", "Nessa")
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

    [departure] = AdmiraltyInletDepartureDesk.departures()
    assert departure.dispatcher == "Corin"
    assert departure.watch == "First watch"
    assert departure.connected_mount? == true
    assert departure.reason == :shutdown
  end
end

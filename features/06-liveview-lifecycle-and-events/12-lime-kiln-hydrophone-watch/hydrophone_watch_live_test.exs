defmodule PhoenixMultivitaminWeb.LimeKilnHydrophoneWatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.LimeKilnHydrophoneBooth

  @path "/features/06-liveview-lifecycle-and-events/12-lime-kiln-hydrophone-watch"

  setup do
    start_supervised!(LimeKilnHydrophoneBooth)
    :ok
  end

  test "the static render runs on_mount once in the HTTP request", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Lime Kiln State Park hydrophone"
    assert html =~ "Asta"
    assert html =~ "Static mount. on_mount still ran, in the HTTP request process."
    assert html =~ "Hook before mount"
    assert html =~ "yes"
    assert LimeKilnHydrophoneBooth.don_count() == 1
  end

  test "live/2 dons the headset twice: static render, then connected mount", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Socket connected. The booth has already run on_mount for this process."
    assert has_element?(view, "#listener-name", "Asta")
    assert has_element?(view, "#hook-then-mount", "yes")
    assert LimeKilnHydrophoneBooth.don_count() == 2
  end

  test "the hook continues orca marks and halts calibration", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#mark-j-pod") |> render_click()

    assert LimeKilnHydrophoneBooth.last_hook() == "mark_orca"
    assert has_element?(view, "#last-species", "Southern Resident")
    assert has_element?(view, "#detections", "Southern Resident pod J")

    view |> element("#calibrate-array") |> render_click()

    assert LimeKilnHydrophoneBooth.last_hook() == "calibrate_array"
    assert has_element?(view, "#calibrated-state", "yes")
    assert has_element?(view, "#detections", "Array calibrated in the on_mount hook")
    refute has_element?(view, "#detections", "LiveView calibrate ran")
  end
end

defmodule PhoenixMultivitaminWeb.RarotongaAtisWatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.RarotongaAtisBooth

  @path "/features/06-liveview-lifecycle-and-events/12-rarotonga-atis-watch"

  setup do
    start_supervised!(RarotongaAtisBooth)
    :ok
  end

  test "the static render runs on_mount once in the HTTP request", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Rarotonga ATIS booth"
    assert html =~ "Manu"
    assert html =~ "Static mount. on_mount still ran, in the HTTP request process."
    assert html =~ "Hook before mount"
    assert html =~ "yes"
    assert RarotongaAtisBooth.don_count() == 1
  end

  test "live/2 dons the headset twice: static render, then connected mount", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Socket connected. The booth has already run on_mount for this process."
    assert has_element?(view, "#tech-name", "Manu")
    assert has_element?(view, "#hook-then-mount", "yes")
    assert RarotongaAtisBooth.don_count() == 2
  end

  test "the hook continues arrival marks and halts calibration", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#mark-arrival") |> render_click()

    assert RarotongaAtisBooth.last_hook() == "mark_arrival"
    assert has_element?(view, "#last-mark", "A350 arrival")
    assert has_element?(view, "#marks", "A350-900 flight ANZ84")

    view |> element("#calibrate-atis") |> render_click()

    assert RarotongaAtisBooth.last_hook() == "calibrate_atis"
    assert has_element?(view, "#calibrated-state", "yes")
    assert has_element?(view, "#marks", "ATIS calibrated in the on_mount hook")
    refute has_element?(view, "#marks", "LiveView calibrate ran")
  end
end

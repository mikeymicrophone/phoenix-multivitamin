defmodule PhoenixMultivitaminWeb.TaipeiSongshanStylusLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/10-taipei-songshan-stylus"

  test "a complete stroke is reduced into peak and mean pressure", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#songshan-stylus[phx-hook$='.PressureStylus'][phx-update='ignore'] canvas")
    assert has_element?(view, "#calibrate-stylus")
    render_hook(view, "record_stylus", %{"pressures" => [25, 50, 75]})
    assert_reply view, %{accepted: true, average: 50.0, peak: 75}
    assert has_element?(view, "#stroke-count", "1 strokes")
    assert has_element?(view, "#pressure-status", "75%")
  end

  test "bad pressure or a stroke outside the size bound is rejected atomically", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "record_stylus", %{"pressures" => [25, 101, 50]})
    assert_reply view, %{accepted: false, reason: "invalid_pressure"}
    for pressures <- [[], List.duplicate(50, 65), "50"] do
      render_hook(view, "record_stylus", %{"pressures" => pressures})
      assert_reply view, %{accepted: false, reason: "stroke_size"}
    end
    assert has_element?(view, "#stroke-count", "0 strokes")
  end
end

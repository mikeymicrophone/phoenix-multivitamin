defmodule PhoenixMultivitaminWeb.YogyakartaBorobudurCanvasLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/04-yogyakarta-borobudur-canvas"

  test "a nested hook position receives an acceptance reply", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#borobudur-lane[phx-hook$='.TowCanvas'][phx-update='ignore'] canvas")
    assert has_element?(view, "#tow-midpoint")
    render_hook(view, "mark_tow_point", %{"position" => %{"metres" => 625}})
    assert_reply view, %{accepted: true, metres: 625}
    assert has_element?(view, "#tow-metres", "625 m")
  end

  test "missing, fractional and out-of-lane positions cannot move the tow point", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    for metres <- [-1, 1001, 12.5, "500"] do
      render_hook(view, "mark_tow_point", %{"position" => %{"metres" => metres}})
      assert_reply view, %{accepted: false, reason: "outside_tow_lane"}
      assert has_element?(view, "#tow-metres", "0 m")
    end

    render_hook(view, "mark_tow_point", %{})
    assert_reply view, %{accepted: false, reason: "missing_position"}
  end
end

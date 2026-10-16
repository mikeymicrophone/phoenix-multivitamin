defmodule PhoenixMultivitaminWeb.VientianeMekongGaugesLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/08-vientiane-mekong-gauges"

  test "a returning hook receives the latest station snapshot", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#mekong-gauges[phx-hook$='.MekongGauges'][phx-update='ignore']")
    render_hook(view, "resume_gauges", %{"revision" => 0})
    assert_reply view, %{accepted: true, revision: 1, readings: %{"pressure_hpa" => 1008, "rain_mm" => 6}}
    view |> element("#post-monsoon") |> render_click()
    assert_push_event view, "vientiane:gauges", %{revision: 2, readings: %{"pressure_hpa" => 1004, "rain_mm" => 18}}
    render_hook(view, "resume_gauges", %{"revision" => 1})
    assert_reply view, %{accepted: true, revision: 2, readings: %{"pressure_hpa" => 1004, "rain_mm" => 18}}
    assert has_element?(view, "#gauge-revision", "2")
  end

  test "malformed reconnect revisions are rejected", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "resume_gauges", %{"revision" => -1})
    assert_reply view, %{accepted: false, reason: "invalid_revision"}
    assert has_element?(view, "#gauge-revision", "1")
  end
end

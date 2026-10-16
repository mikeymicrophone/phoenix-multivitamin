defmodule PhoenixMultivitaminWeb.KuchingHornbillRulerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/05-kuching-hornbill-ruler"

  test "fleet selection pushes a filtered scale to the ruler", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#hornbill-ruler[phx-hook$='.WingRuler'][phx-update='ignore']")
    view |> element("#measure-dornier") |> render_click()
    assert_push_event view, "kuching:ruler", %{span: 17, ticks: [0, 2, 4, 6, 8, 10, 12, 14, 16]}
    assert has_element?(view, "#ruler-status", "17 m")
    view |> element("#measure-otter") |> render_click()
    assert_push_event view, "kuching:ruler", %{span: 20, ticks: [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20]}
  end

  test "an unknown fleet never sends a calibration", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "calibrate_span", %{"fleet" => "unregistered"})
    assert has_element?(view, "#ruler-status", "No wing span")
    refute_push_event view, "kuching:ruler", _scale
    render_hook(view, "calibrate_span", %{})
    assert has_element?(view, "#ruler-status", "recorded fleet")
  end
end

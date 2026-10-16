defmodule PhoenixMultivitaminWeb.KansaiIzumisanoAlignerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/13-kansai-izumisano-aligner"

  test "the handshake, sensor reply and pushed report share a sequence", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#izumisano-aligner[phx-hook$='.NosewheelAligner'][phx-update='ignore']")
    assert has_element?(view, "#measure-nosewheel[disabled]")
    render_hook(view, "read_alignment", %{})
    assert_reply view, %{sequence: 0, aligned: true}
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{"left_mm" => 2, "right_mm" => 4}})
    assert_reply view, %{accepted: true, sequence: 1}
    assert_push_event view, "kansai:alignment", %{sequence: 1, aligned: true, label: "Stand 26: 3 mm / spread 2 mm"}
    assert has_element?(view, "#alignment-report", "3 mm / spread 2 mm")
    assert has_element?(view, "#alignment-sequence", "1")
  end

  test "bad sensors and stale sequences cannot advance the instrument", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{"left_mm" => 41, "right_mm" => 0}})
    assert_reply view, %{accepted: false, reason: "sensor_out_of_range"}
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{}})
    assert_reply view, %{accepted: false, reason: "unreadable_sensors"}
    assert has_element?(view, "#alignment-sequence", "0")
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{"left_mm" => -12, "right_mm" => 12}})
    assert_reply view, %{accepted: true, sequence: 1}
    assert_push_event view, "kansai:alignment", %{sequence: 1, aligned: false}
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{"left_mm" => 0, "right_mm" => 0}})
    assert_reply view, %{accepted: false, reason: "stale_or_closed_instrument"}
    assert has_element?(view, "#alignment-sequence", "1")
    refute_push_event view, "kansai:alignment", _alignment
  end

  test "stowing removes the hook and redeploying retains the authoritative report", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> element("#toggle-aligner") |> render_click()
    refute has_element?(view, "#izumisano-aligner")
    render_hook(view, "align_nosewheel", %{"sequence" => 0, "sensors" => %{"left_mm" => 0, "right_mm" => 0}})
    assert_reply view, %{accepted: false, reason: "stale_or_closed_instrument"}
    view |> element("#toggle-aligner") |> render_click()
    assert has_element?(view, "#izumisano-aligner")
    render_hook(view, "read_alignment", %{})
    assert_reply view, %{sequence: 0, aligned: true}
  end
end

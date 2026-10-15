defmodule PhoenixMultivitaminWeb.PointNoPointStaffGateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.PointNoPointStaffGateLive

  @path "/features/02-verified-routes/07-point-no-point-staff-gate"

  test "an empty query omits the question mark" do
    assert PointNoPointStaffGateLive.gate_path() == @path
    assert PointNoPointStaffGateLive.gate_path([]) == @path
    assert PointNoPointStaffGateLive.gate_path(%{}) == @path
    refute PointNoPointStaffGateLive.gate_path([]) =~ "?"
  end

  test "nil query values are omitted; false still encodes" do
    assert PointNoPointStaffGateLive.gate_path(crew: nil, tide: "ebb") == "#{@path}?tide=ebb"
    assert PointNoPointStaffGateLive.gate_path(relief: false) == "#{@path}?relief=false"

    assert PointNoPointStaffGateLive.gate_path(crew: "relief boat") ==
             "#{@path}?crew=relief+boat"
  end

  test "the gate patches between omitted and present query keys", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Point No Point Light"
    assert html =~ "Willa"
    assert has_element?(view, "#bare-gate-path", @path)
    refute has_element?(view, "#bare-gate-path", "?")
    assert has_element?(view, "#omitted-gate-path", "#{@path}?tide=ebb")
    assert has_element?(view, "#false-gate-path", "#{@path}?relief=false")
    assert has_element?(view, "#gate-crew", "none")

    view |> element("#admit-relief-boat") |> render_click()
    assert_patch(view, "#{@path}?crew=relief+boat")
    assert has_element?(view, "#gate-crew", "relief boat")

    view |> element("#log-ebb") |> render_click()
    assert_patch(view, "#{@path}?tide=ebb")
    assert has_element?(view, "#gate-tide", "ebb")
    assert has_element?(view, "#gate-crew", "none")

    view |> element("#mark-no-relief") |> render_click()
    assert_patch(view, "#{@path}?relief=false")
    assert has_element?(view, "#gate-relief", "false")

    view |> element("#open-bare") |> render_click()
    assert_patch(view, @path)
  end
end

defmodule PhoenixMultivitaminWeb.GibraltarStaffGateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.GibraltarStaffGateLive

  @path "/features/02-verified-routes/07-gibraltar-staff-gate"

  test "an empty query omits the question mark" do
    assert GibraltarStaffGateLive.gate_path() == @path
    assert GibraltarStaffGateLive.gate_path([]) == @path
    assert GibraltarStaffGateLive.gate_path(%{}) == @path
    refute GibraltarStaffGateLive.gate_path([]) =~ "?"
  end

  test "nil query values encode as empty; false still encodes; missing keys omit" do
    assert GibraltarStaffGateLive.gate_path(crew: nil, qnh: "1013") ==
             "#{@path}?crew=&qnh=1013"

    assert GibraltarStaffGateLive.gate_path(qnh: "1013") == "#{@path}?qnh=1013"
    assert GibraltarStaffGateLive.gate_path(relief: false) == "#{@path}?relief=false"

    assert GibraltarStaffGateLive.gate_path(crew: "relief van") ==
             "#{@path}?crew=relief+van"
  end

  test "the gate patches between omitted and present query keys", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Gibraltar staff gate"
    assert html =~ "Amira"
    assert has_element?(view, "#bare-gate-path", @path)
    refute has_element?(view, "#bare-gate-path", "?")
    assert has_element?(view, "#nil-crew-gate-path", "#{@path}?crew=&qnh=1013")
    assert has_element?(view, "#qnh-only-gate-path", "#{@path}?qnh=1013")
    assert has_element?(view, "#false-gate-path", "#{@path}?relief=false")
    assert has_element?(view, "#gate-crew", "none")

    view |> element("#admit-relief-van") |> render_click()
    assert_patch(view, "#{@path}?crew=relief+van")
    assert has_element?(view, "#gate-crew", "relief van")

    view |> element("#log-qnh") |> render_click()
    assert_patch(view, "#{@path}?crew=&qnh=1013")
    assert has_element?(view, "#gate-qnh", "1013")
    assert has_element?(view, "#gate-crew", "none")

    view |> element("#mark-no-relief") |> render_click()
    assert_patch(view, "#{@path}?relief=false")
    assert has_element?(view, "#gate-relief", "false")

    view |> element("#open-bare") |> render_click()
    assert_patch(view, @path)
  end
end

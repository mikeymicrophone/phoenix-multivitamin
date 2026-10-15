defmodule PhoenixMultivitaminWeb.AdmiraltyInletTideGateTest do
  use PhoenixMultivitaminWeb.ConnCase

  @inlet "/features/01-routing-and-plugs/01-admiralty-inlet-tide-gate/inlet"

  test "the pipeline plug runs, then the controller function plugs, then the board", %{
    conn: conn
  } do
    conn = get(conn, @inlet)
    html = html_response(conn, 200)

    assert html =~ "Admiralty Inlet"
    assert html =~ "Point Wilson tide gate"
    assert html =~ "flood through Partridge Bank"
    assert html =~ "Maren"
    assert html =~ "GET"

    inlet_at = :binary.match(html, "inlet-pipeline")
    window_at = :binary.match(html, "gate-window")
    meta_at = :binary.match(html, "request-meta")

    assert elem(inlet_at, 0) < elem(window_at, 0)
    assert elem(window_at, 0) < elem(meta_at, 0)
  end
end

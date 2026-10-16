defmodule PhoenixMultivitaminWeb.LuklaShearGateTest do
  use PhoenixMultivitaminWeb.ConnCase

  @approach "/features/01-routing-and-plugs/01-lukla-shear-gate/approach"

  test "the pipeline plug runs, then the controller function plugs, then the board", %{
    conn: conn
  } do
    conn = get(conn, @approach)
    html = html_response(conn, 200)

    assert html =~ "Khumbu approach"
    assert html =~ "Lukla shear gate"
    assert html =~ "westerly rotor off Nupla"
    assert html =~ "Tashi"
    assert html =~ "GET"

    approach_at = :binary.match(html, "trace-approach-pipeline")
    window_at = :binary.match(html, "trace-shear-window")
    meta_at = :binary.match(html, "trace-request-meta")

    assert elem(approach_at, 0) < elem(window_at, 0)
    assert elem(window_at, 0) < elem(meta_at, 0)
  end
end

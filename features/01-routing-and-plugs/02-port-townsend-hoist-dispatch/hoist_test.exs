defmodule PhoenixMultivitaminWeb.PortTownsendHoistDispatchTest do
  use PhoenixMultivitaminWeb.ConnCase

  @yard "/features/01-routing-and-plugs/02-port-townsend-hoist-dispatch/yard"

  test "a missing boat-yard ticket halts before the dispatcher", %{conn: conn} do
    conn = get(conn, @yard)
    html = html_response(conn, 401)

    assert html =~ "Hoist ticket missing"
    assert html =~ "The Travelift stays locked"
    refute html =~ "Ticket hoist-17 accepted"
    refute html =~ "troller Marigold"
  end

  test "ticket hoist-17 reaches dispatcher Hollis and the Travelift", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-boat-yard-ticket", "hoist-17")
      |> get(@yard)

    html = html_response(conn, 200)

    assert html =~ "Ticket hoist-17 accepted"
    assert html =~ "Hollis"
    assert html =~ "Travelift 17"
    assert html =~ "troller Marigold"
    refute html =~ "Hoist ticket missing"
  end
end

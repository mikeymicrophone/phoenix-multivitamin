defmodule PhoenixMultivitaminWeb.TromsoSarHoistTest do
  use PhoenixMultivitaminWeb.ConnCase

  @pad "/features/01-routing-and-plugs/02-tromso-sar-hoist/pad"

  test "a missing winch ticket halts before the dispatcher", %{conn: conn} do
    conn = get(conn, @pad)
    html = html_response(conn, 401)

    assert html =~ "Hoist ticket missing"
    assert html =~ "The Sea King winch stays locked"
    refute html =~ "Ticket hoist-17 accepted"
    refute html =~ "Westland Sea King"
  end

  test "ticket hoist-17 reaches winch operator Sigrid and the Sea King", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-winch-ticket", "hoist-17")
      |> get(@pad)

    html = html_response(conn, 200)

    assert html =~ "Ticket hoist-17 accepted"
    assert html =~ "Sigrid"
    assert html =~ "Sea King winch 17"
    assert html =~ "Westland Sea King"
    refute html =~ "Hoist ticket missing"
  end
end

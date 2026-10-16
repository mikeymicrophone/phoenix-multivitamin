defmodule PhoenixMultivitaminWeb.ParoInboundLogTest do
  use PhoenixMultivitaminWeb.ConnCase

  @valley "/features/01-routing-and-plugs/04-paro-inbound-log/valley"
  @druk @valley <> "/a319/druk"

  test "forward keeps the full request_path and puts the prefix in script_name", %{conn: conn} do
    conn = get(conn, @valley)
    html = html_response(conn, 200)

    assert html =~ "Paro valley"
    assert html =~ "Kinley"
    assert html =~ @valley
    assert html =~ "features/01-routing-and-plugs/04-paro-inbound-log/valley"
    assert html =~ "Paro inbound A319"
  end

  test "the inner A319 route sees a stripped path_info and the reg param", %{conn: conn} do
    conn = get(conn, @druk)
    html = html_response(conn, 200)

    assert html =~ "Drukair A319"
    assert html =~ "druk"
    assert html =~ @druk
    assert conn.params["reg"] == "druk"
    assert html =~ "a319/druk"
  end
end

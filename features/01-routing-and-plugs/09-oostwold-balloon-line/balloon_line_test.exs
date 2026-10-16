defmodule PhoenixMultivitaminWeb.OostwoldBalloonLineTest do
  use PhoenixMultivitaminWeb.ConnCase

  @line "/features/01-routing-and-plugs/09-oostwold-balloon-line/line"

  test "assigns reach the template; private fields do not until the controller copies them", %{
    conn: conn
  } do
    conn = get(conn, @line)
    html = html_response(conn, 200)

    assert html =~ "Oostwold balloon meadow"
    assert html =~ "Polder Groen"
    assert html =~ "Bram"
    assert html =~ "not on assigns"
    assert html =~ "polder-green"
    assert html =~ "Eelde balloon net"
    refute conn.assigns[:launch_code]
    assert conn.private[:launch_code] == "polder-green"
  end
end

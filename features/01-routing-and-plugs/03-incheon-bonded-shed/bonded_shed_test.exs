defmodule PhoenixMultivitaminWeb.IncheonBondedShedTest do
  use PhoenixMultivitaminWeb.ConnCase

  @arrivals "/features/01-routing-and-plugs/03-incheon-bonded-shed/arrivals/declarations"
  @departures "/features/01-routing-and-plugs/03-incheon-bonded-shed/departures/declarations"

  test "the arrivals scope lists the KE pallet run and stamps the arrivals lane", %{conn: conn} do
    conn = get(conn, @arrivals)
    html = html_response(conn, 200)

    assert html =~ "Incheon bonded shed"
    assert html =~ "arrivals"
    assert html =~ "Haneul"
    assert html =~ "KE pallet run"
    refute html =~ "OZ re-export van"
  end

  test "the departures scope lists the OZ van on its own prefix", %{conn: conn} do
    conn = get(conn, @departures)
    html = html_response(conn, 200)

    assert html =~ "departures"
    assert html =~ "OZ re-export van"
    refute html =~ "KE pallet run"
  end

  test "a numeric-looking declaration id is still a string", %{conn: conn} do
    conn = get(conn, @arrivals <> "/17")
    html = html_response(conn, 200)

    assert html =~ "ULD train 17"
    assert html =~ "17"
    assert html =~ "yes"
    assert conn.params["id"] == "17"
    assert is_binary(conn.params["id"])
  end
end

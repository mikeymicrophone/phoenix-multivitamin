defmodule PhoenixMultivitaminWeb.FridayHarborCustomsShedTest do
  use PhoenixMultivitaminWeb.ConnCase

  @arrivals "/features/01-routing-and-plugs/03-friday-harbor-customs-shed/arrivals/declarations"
  @departures "/features/01-routing-and-plugs/03-friday-harbor-customs-shed/departures/declarations"

  test "the arrivals scope lists the Coho and stamps the arrivals lane", %{conn: conn} do
    conn = get(conn, @arrivals)
    html = html_response(conn, 200)

    assert html =~ "Friday Harbor customs shed"
    assert html =~ "arrivals"
    assert html =~ "Ellis"
    assert html =~ "MV Coho"
    refute html =~ "whale-watch Osprey"
  end

  test "the departures scope lists Osprey on its own prefix", %{conn: conn} do
    conn = get(conn, @departures)
    html = html_response(conn, 200)

    assert html =~ "departures"
    assert html =~ "whale-watch Osprey"
    refute html =~ "MV Coho"
  end

  test "a numeric-looking declaration id is still a string", %{conn: conn} do
    conn = get(conn, @arrivals <> "/17")
    html = html_response(conn, 200)

    assert html =~ "Harbor Patrol 17"
    assert html =~ "17"
    assert html =~ "yes"
    assert conn.params["id"] == "17"
    assert is_binary(conn.params["id"])
  end
end

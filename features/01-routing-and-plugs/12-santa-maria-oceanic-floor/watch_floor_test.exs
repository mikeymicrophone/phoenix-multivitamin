defmodule PhoenixMultivitaminWeb.SantaMariaOceanicFloorTest do
  use PhoenixMultivitaminWeb.ConnCase

  @santa_maria "/features/01-routing-and-plugs/12-santa-maria-oceanic-floor/station/santa-maria/watch/evening/floor"
  @relief "/features/01-routing-and-plugs/12-santa-maria-oceanic-floor/relief/floor"

  test "nested scopes concatenate prefixes and accumulate both plugs", %{conn: conn} do
    conn = get(conn, @santa_maria)
    html = html_response(conn, 200)

    assert html =~ "Santa Maria Oceanic"
    assert html =~ "santa-maria"
    assert html =~ "evening"
    assert html =~ "Duarte"
    assert html =~ "oceanic"
    assert html =~ "watch"
    assert conn.params["station"] == "santa-maria"
    assert conn.params["watch"] == "evening"
    assert is_binary(conn.params["station"])

    oceanic_at = :binary.match(html, "oceanic")
    watch_at = :binary.match(html, ">watch<")
    assert elem(oceanic_at, 0) < elem(watch_at, 0)
  end

  test "a sibling relief scope runs the watch plug without the oceanic plug", %{conn: conn} do
    conn = get(conn, @relief)
    html = html_response(conn, 200)

    assert html =~ "relief radio"
    assert html =~ "watch"
    assert html =~ "not on this scope"
    refute html =~ "id=\"trace-oceanic\""
  end
end

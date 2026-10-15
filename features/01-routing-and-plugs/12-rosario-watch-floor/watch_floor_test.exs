defmodule PhoenixMultivitaminWeb.RosarioWatchFloorTest do
  use PhoenixMultivitaminWeb.ConnCase

  @lime_kiln "/features/01-routing-and-plugs/12-rosario-watch-floor/station/lime-kiln/watch/evening/floor"
  @relief "/features/01-routing-and-plugs/12-rosario-watch-floor/relief/floor"

  test "nested scopes concatenate prefixes and accumulate both plugs", %{conn: conn} do
    conn = get(conn, @lime_kiln)
    html = html_response(conn, 200)

    assert html =~ "Rosario Strait"
    assert html =~ "lime-kiln"
    assert html =~ "evening"
    assert html =~ "Nessa"
    assert html =~ "strait"
    assert html =~ "watch"
    assert conn.params["station"] == "lime-kiln"
    assert conn.params["watch"] == "evening"
    assert is_binary(conn.params["station"])

    strait_at = :binary.match(html, "strait")
    watch_at = :binary.match(html, ">watch<")
    assert elem(strait_at, 0) < elem(watch_at, 0)
  end

  test "a sibling relief scope runs the watch plug without the strait plug", %{conn: conn} do
    conn = get(conn, @relief)
    html = html_response(conn, 200)

    assert html =~ "relief boat"
    assert html =~ "watch"
    assert html =~ "not on this scope"
    refute html =~ "id=\"trace-strait\""
  end
end

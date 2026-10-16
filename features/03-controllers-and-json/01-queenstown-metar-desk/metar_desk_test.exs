defmodule PhoenixMultivitaminWeb.QueenstownMetarDeskTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/01-queenstown-metar-desk"
  @metar @map <> "/metar"
  @export @map <> "/metar/export"

  test "the catalog page links the HTML board and the JSON export", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-metar")
    assert Phoenix.LiveViewTest.has_element?(view, "#export-metar")
  end

  test "show/2 renders the METAR as HTML", %{conn: conn} do
    conn = get(conn, @metar)
    html = html_response(conn, 200)
    assert html =~ "NZQN"
    assert html =~ "Kahu"
    assert html =~ "32015G28KT"
    assert html =~ "King Air 200"
  end

  test "export/2 returns the same METAR as JSON without the HTML view", %{conn: conn} do
    conn = get(conn, @export)
    body = json_response(conn, 200)
    assert body["format"] == "json"
    assert body["metar"]["station"] == "NZQN"
    assert body["metar"]["observer"] == "Kahu"
    refute html_response_like?(conn)
  end

  defp html_response_like?(conn) do
    conn.resp_body =~ "<html"
  end
end

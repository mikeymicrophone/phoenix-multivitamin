defmodule PhoenixMultivitaminWeb.MarrakechAtisFeedTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/03-marrakech-atis-feed"
  @atis @map <> "/atis"

  test "the catalog page links the ATIS board", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-atis")
  end

  test "show/2 renders the current information Bravo", %{conn: conn} do
    conn = get(conn, @atis)
    html = html_response(conn, 200)
    assert html =~ "BRAVO"
    assert html =~ "Youssef"
    assert html =~ "GMMX"
  end

  test "a valid post is 201 JSON from the action, not the fallback", %{conn: conn} do
    conn = post(conn, @atis, %{atis: %{info: "CHARLIE RWY 10", wind: "25014KT"}})
    body = json_response(conn, 201)
    assert body["atis"]["info"] == "CHARLIE RWY 10"
    assert body["atis"]["clerk"] == "Youssef"
    refute Map.has_key?(body, "error")
  end

  test "a short info line is 422 from the fallback changeset map", %{conn: conn} do
    conn = post(conn, @atis, %{atis: %{info: "CH", wind: "25014KT"}})
    body = json_response(conn, 422)
    assert body["error"] == "invalid_atis"
    assert body["errors"]["info"] == ["should be at least %{count} character(s)"]
  end
end

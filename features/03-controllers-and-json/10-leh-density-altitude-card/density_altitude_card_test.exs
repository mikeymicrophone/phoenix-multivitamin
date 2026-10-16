defmodule PhoenixMultivitaminWeb.LehDensityAltitudeCardTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/10-leh-density-altitude-card"
  @card @map <> "/card"

  test "the catalog page links the card", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-card")
  end

  test "show/2 renders the empty card board", %{conn: conn} do
    conn = get(conn, @card)
    html = html_response(conn, 200)
    assert html =~ "Tenzin"
    assert html =~ "Antonov An-32"
  end

  test "nested card params match the domain clause", %{conn: conn} do
    conn = post(conn, @card, %{card: %{oat_c: "22", elevation_ft: "10682"}})
    body = json_response(conn, 201)
    assert body["nested"] == true
    assert body["card"]["oat_c"] == "22"
    assert body["card"]["elevation_ft"] == "10682"
    assert body["card"]["engineer"] == "Tenzin"
    assert body["card"]["density_altitude_ft"] == 10_682 + (22 - 15) * 120
  end

  test "a flat param map misses the nested clause", %{conn: conn} do
    conn = post(conn, @card, %{oat_c: "22", elevation_ft: "10682"})
    body = json_response(conn, 422)
    assert body["nested"] == false
    assert body["error"] == "card_missing"
  end
end

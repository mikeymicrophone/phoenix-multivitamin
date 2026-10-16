defmodule PhoenixMultivitaminWeb.LehDensityAltitudeCardTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/03-controllers-and-json/10-leh-density-altitude-card"
  @card @map <> "/card"

  test "the catalog page links the card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#open-card")
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

  test "malformed nested readings return validation errors", %{conn: conn} do
    for reading <- ["22C", "", "warm", nil, 22, ["22"]] do
      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(@card, Jason.encode!(%{card: %{oat_c: reading, elevation_ft: "10682"}}))

      assert %{"nested" => true, "error" => "card_reading_invalid"} = json_response(response, 422)
    end
  end

  test "a partial elevation does not reach the calculation", %{conn: conn} do
    conn = post(conn, @card, %{card: %{oat_c: "22", elevation_ft: "10682ft"}})

    assert %{"nested" => true, "error" => "card_reading_invalid"} = json_response(conn, 422)
  end
end

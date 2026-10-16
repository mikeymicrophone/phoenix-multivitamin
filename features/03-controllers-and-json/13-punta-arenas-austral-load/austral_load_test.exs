defmodule PhoenixMultivitaminWeb.PuntaArenasAustralLoadTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/13-punta-arenas-austral-load"
  @index @map <> "/loads"
  @show @map <> "/loads/teniente"
  @missing @map <> "/loads/missing"

  test "the catalog page links the index and the Teniente pallet", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-loads")
    assert Phoenix.LiveViewTest.has_element?(view, "#open-teniente-load")
  end

  test "index/2 is a JSON collection of austral loads", %{conn: conn} do
    conn = get(conn, @index)
    body = json_response(conn, 200)
    assert body["station"] == "SCCI"
    assert length(body["loads"]) == 2
    assert Enum.any?(body["loads"], &(&1["id"] == "teniente"))
  end

  test "show/2 renders the Teniente pallet as HTML", %{conn: conn} do
    conn = get(conn, @show)
    html = html_response(conn, 200)
    assert html =~ "Teniente Marsh"
    assert html =~ "Cristóbal"
    assert html =~ "Lockheed C-130"
    assert html =~ "fuel bladders"
  end

  test "a missing load is 404 from the fallback", %{conn: conn} do
    conn = get(conn, @missing)
    body = json_response(conn, 404)
    assert body["via"] == "fallback"
    assert body["error"] == "load_missing"
  end

  test "a valid create is 201 JSON from the action", %{conn: conn} do
    conn = post(conn, @index, %{load: %{destination: "Marambio", cargo: "generator"}})
    body = json_response(conn, 201)
    assert body["load"]["destination"] == "Marambio"
    assert body["load"]["loadmaster"] == "Cristóbal"
  end

  test "a short destination is 422 from the fallback changeset", %{conn: conn} do
    conn = post(conn, @index, %{load: %{destination: "X", cargo: "generator"}})
    body = json_response(conn, 422)
    assert body["via"] == "fallback"
    assert body["error"] == "invalid_load"
  end
end

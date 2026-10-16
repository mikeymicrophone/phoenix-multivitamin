defmodule PhoenixMultivitaminWeb.UlaanbaatarWinterNotamTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/04-ulaanbaatar-winter-notam"
  @ice @map <> "/notams/ubbn-ice"
  @missing @map <> "/notams/missing"
  @explode @map <> "/explode"

  test "the catalog page links ice, missing, and explode", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-ice-notam")
    assert Phoenix.LiveViewTest.has_element?(view, "#open-missing-notam")
    assert Phoenix.LiveViewTest.has_element?(view, "#open-explode")
  end

  test "a known series is JSON from the action", %{conn: conn} do
    conn = get(conn, @ice)
    body = json_response(conn, 200)
    assert body["via"] == "action"
    assert body["notam"]["series"] == "A0123/26"
    assert body["notam"]["clerk"] == "Oyuna"
    assert body["notam"]["craft"] == "Fokker 100"
  end

  test "a missing series is 404 from the fallback, not a rescued clause", %{conn: conn} do
    conn = get(conn, @missing)
    body = json_response(conn, 404)
    assert body["via"] == "fallback"
    assert body["error"] == "notam_missing"
  end

  test "a bad runway letter is 422 from rescue, and via is not fallback", %{conn: conn} do
    conn = get(conn, @explode)
    body = json_response(conn, 422)
    assert body["via"] == "rescue"
    refute body["via"] == "fallback"
    assert is_binary(body["error"])
  end
end

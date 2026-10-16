defmodule PhoenixMultivitaminWeb.MaleAtollSlotListTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/09-male-atoll-slot-list"
  @known @map <> "/slots/hulhule-14"
  @missing @map <> "/slots/missing"

  test "the catalog page links a known slot and a missing one", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-hulhule-slot")
    assert Phoenix.LiveViewTest.has_element?(view, "#open-missing-slot")
  end

  test "a known water slot is JSON", %{conn: conn} do
    conn = get(conn, @known)
    body = json_response(conn, 200)
    assert body["slot"]["island"] == "Hulhulé"
    assert body["slot"]["craft"] == "Airbus A321"
    assert body["slot"]["clerk"] == "Mariyam"
  end

  test "a missing slot is a JSON 404 map, not the HTML Not Found page", %{conn: conn} do
    conn = get(conn, @missing)
    body = json_response(conn, 404)
    assert body["error"] == "slot_missing"
    assert body["id"] == "missing"
    assert body["station"] == "VRMM"
    refute conn.resp_body =~ "<html"
    refute conn.resp_body == "Not Found"
  end
end

defmodule PhoenixMultivitaminWeb.BaltraBiosecurityPassTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/03-controllers-and-json/12-baltra-biosecurity-pass"
  @galapagos @map <> "/passes/galapagos"
  @transit @map <> "/passes/transit"
  @unknown @map <> "/passes/unknown"

  test "the catalog page links each pass kind", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#open-galapagos-pass")
    assert has_element?(view, "#open-transit-pass")
    assert has_element?(view, "#open-unknown-pass")
  end

  test "the galapagos clause scrubs boots and refuses fruit", %{conn: conn} do
    conn = get(conn, @galapagos)
    html = html_response(conn, 200)
    assert html =~ "galapagos"
    assert html =~ "scrubbed"
    assert html =~ "refused"
    assert html =~ "Paz"
    refute html =~ "sealed"
  end

  test "the transit clause is a different show/2 head", %{conn: conn} do
    conn = get(conn, @transit)
    html = html_response(conn, 200)
    assert html =~ "transit"
    assert html =~ "stay-on"
    assert html =~ "sealed"
    refute html =~ "scrubbed"
  end

  test "an unknown kind hits the last clause as JSON 404", %{conn: conn} do
    conn = get(conn, @unknown)
    body = json_response(conn, 404)
    assert body["error"] == "unknown_pass"
    assert body["kind"] == "unknown"
  end
end

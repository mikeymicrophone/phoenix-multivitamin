defmodule PhoenixMultivitaminWeb.LhasaOxygenPlanTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/03-controllers-and-json/11-lhasa-oxygen-plan"
  @ticket @map <> "/ticket"

  test "the catalog page links the oxygen ticket", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#open-ticket")
  end

  test "send_resp/3 writes a text ticket without an HTML view", %{conn: conn} do
    conn = get(conn, @ticket)
    assert response(conn, 200) =~ "LHAS OXYGEN PLAN"
    assert conn.resp_body =~ "planner=Dawa"
    assert conn.resp_body =~ "craft=Comac C919"
    assert conn.resp_body =~ "masks=ready"
    assert get_resp_header(conn, "content-type") |> hd() =~ "text/plain"
    refute conn.resp_body =~ "<html"
    refute conn.resp_body =~ "catalog-shell"
  end
end

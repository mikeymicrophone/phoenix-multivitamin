defmodule PhoenixMultivitaminWeb.BarilocheChinookBriefTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/05-bariloche-chinook-brief"
  @brief @map <> "/brief"

  test "the catalog page links the accepted brief", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-brief")
  end

  test "put_status(:accepted) then render/3 is 202 with the brief body", %{conn: conn} do
    conn = get(conn, @brief)
    html = html_response(conn, 202)
    assert html =~ "Sofía"
    assert html =~ "CH-47 Chinook"
    assert html =~ "Catedral saddle"
    assert html =~ "accepted"
    assert conn.status == 202
  end
end

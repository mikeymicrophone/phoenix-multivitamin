defmodule PhoenixMultivitaminWeb.PrestwickAtlanticTitleLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/06-prestwick-atlantic-title"

  test "the root layout suffix sits on the assigned page_title", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)
    assert html =~ "Prestwick Atlantic title · Phoenix"
    assert html =~ "Mhairi"
    assert html =~ "Airbus A380"
  end

  test "retitling keeps the layout suffix", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_click(element(view, "#retitle-crossing"))
    assert html =~ "Prestwick A380 crossing"
  end
end

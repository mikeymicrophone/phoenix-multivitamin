defmodule PhoenixMultivitaminWeb.NeahBayEntranceLogTest do
  use PhoenixMultivitaminWeb.ConnCase

  @entrance "/features/01-routing-and-plugs/04-neah-bay-entrance-log/entrance"
  @whaler @entrance <> "/canoe/whaler"

  test "forward keeps the full request_path and puts the prefix in script_name", %{conn: conn} do
    conn = get(conn, @entrance)
    html = html_response(conn, 200)

    assert html =~ "Neah Bay entrance"
    assert html =~ "Chenoa"
    assert html =~ @entrance
    assert html =~ "features/01-routing-and-plugs/04-neah-bay-entrance-log/entrance"
    assert html =~ "Makah fishing canoe"
  end

  test "the inner canoe route sees a stripped path_info and the hull param", %{conn: conn} do
    conn = get(conn, @whaler)
    html = html_response(conn, 200)

    assert html =~ "Makah whaling canoe"
    assert html =~ "whaler"
    assert html =~ @whaler
    assert conn.params["hull"] == "whaler"
    assert html =~ "canoe/whaler"
  end
end

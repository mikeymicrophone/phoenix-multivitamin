defmodule PhoenixMultivitaminWeb.CuscoLoadSheetTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/03-controllers-and-json/02-cusco-load-sheet"
  @sheet @map <> "/sheet"

  test "the catalog page links the accepted sheet", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#open-sheet")
  end

  test "json/2 after put_status(:created) is 201 with the load sheet", %{conn: conn} do
    conn = get(conn, @sheet)
    body = json_response(conn, 201)
    assert body["status"] == "accepted"
    assert body["load_sheet"]["station"] == "SPZO"
    assert body["load_sheet"]["loader"] == "Inti"
    assert body["load_sheet"]["craft"] == "Boeing 737-700"
    assert body["load_sheet"]["takeoff_weight_kg"] == 62_400
  end
end

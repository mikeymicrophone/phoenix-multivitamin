defmodule PhoenixMultivitaminWeb.WillapaSeedBargeOfficeTest do
  use PhoenixMultivitaminWeb.ConnCase

  @office "/features/01-routing-and-plugs/05-willapa-seed-barge-office/office"

  test "init/1 options appear on the barge office as assigns", %{conn: conn} do
    conn = get(conn, @office)
    html = html_response(conn, 200)

    assert html =~ "Nahcotta"
    assert html =~ "Pacific oyster spat"
    assert html =~ "Oyster Queen"
    assert html =~ "Nadine"
    assert html =~ "landing crop barge"
  end

  test "init/1 returns a map, not the original keyword list" do
    opts =
      PhoenixMultivitaminWeb.WillapaSeedBargePlug.init(
        landing: "Nahcotta",
        crop: "Pacific oyster spat",
        barge: "Oyster Queen"
      )

    assert opts == %{
             landing: "Nahcotta",
             crop: "Pacific oyster spat",
             barge: "Oyster Queen"
           }
  end
end

defmodule PhoenixMultivitaminWeb.ShannonAvgasOfficeTest do
  use PhoenixMultivitaminWeb.ConnCase

  @bowser "/features/01-routing-and-plugs/05-shannon-avgas-office/bowser"

  test "init/1 options appear on the avgas office as assigns", %{conn: conn} do
    conn = get(conn, @bowser)
    html = html_response(conn, 200)

    assert html =~ "Shannon"
    assert html =~ "100LL"
    assert html =~ "Avgas 1"
    assert html =~ "Orla"
    assert html =~ "apron grade bowser"
  end

  test "init/1 returns a map, not the original keyword list" do
    opts =
      PhoenixMultivitaminWeb.ShannonAvgasPlug.init(
        apron: "Shannon",
        grade: "100LL",
        bowser: "Avgas 1"
      )

    assert opts == %{
             apron: "Shannon",
             grade: "100LL",
             bowser: "Avgas 1"
           }
  end
end

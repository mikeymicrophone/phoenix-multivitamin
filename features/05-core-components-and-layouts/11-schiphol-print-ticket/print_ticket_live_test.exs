defmodule PhoenixMultivitaminWeb.SchipholPrintTicketLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/05-core-components-and-layouts/11-schiphol-print-ticket"
  @print @map <> "/print"

  test "the catalog card links the nested print jacket", %{conn: conn} do
    {:ok, view, html} = live(conn, @map)
    assert has_element?(view, "#open-print")
    assert html =~ "Saskia"
    assert html =~ "Embraer E190"
    refute has_element?(view, "#print-jacket")
  end

  test "the print path nests the jacket inside the catalog layout", %{conn: conn} do
    {:ok, view, html} = live(conn, @print)
    assert has_element?(view, "#print-jacket")
    assert has_element?(view, "#print-banner", "print jacket")
    assert has_element?(view, "#marshal-name", "Saskia")
    assert html =~ "catalog-shell"
    assert html =~ "Schiphol print ticket"
  end
end

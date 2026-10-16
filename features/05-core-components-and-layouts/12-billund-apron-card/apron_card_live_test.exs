defmodule PhoenixMultivitaminWeb.BillundApronCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/12-billund-apron-card"

  test "the catalog brand names no station; the card names Billund", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#marshal-name", "Mads")
    assert has_element?(view, "#craft-name", "CRJ900")
    assert html =~ "Billund apron card"

    assert has_element?(view, ".catalog-brand", "Phoenix Multivitamin")
    refute has_element?(view, ".catalog-brand", "Billund")
    refute has_element?(view, ".catalog-brand", "Mads")
    refute has_element?(view, ".catalog-brand", "CRJ900")
    refute has_element?(view, ".catalog-nav", "Billund")
  end
end

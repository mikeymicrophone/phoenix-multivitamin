defmodule PhoenixMultivitaminWeb.BillundApronCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/12-billund-apron-card"

  test "the catalog brand names no station; the card names Billund", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#marshal-name", "Mads")
    assert has_element?(view, "#craft-name", "CRJ900")
    assert html =~ "Billund apron card"

    brand = LazyHTML.filter(LazyHTML.from_fragment(html), ".catalog-brand")
    brand_text = brand |> LazyHTML.text() |> IO.iodata_to_binary()
    assert brand_text =~ "Phoenix Multivitamin"
    refute brand_text =~ "Billund"
    refute brand_text =~ "Mads"
    refute brand_text =~ "CRJ900"

    nav = LazyHTML.filter(LazyHTML.from_fragment(html), ".catalog-nav")
    nav_text = nav |> LazyHTML.text() |> IO.iodata_to_binary()
    refute nav_text =~ "Billund"
  end
end

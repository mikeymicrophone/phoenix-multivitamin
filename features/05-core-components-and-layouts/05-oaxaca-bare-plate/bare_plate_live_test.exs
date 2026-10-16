defmodule PhoenixMultivitaminWeb.OaxacaBarePlateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/05-oaxaca-bare-plate"

  test "the plate renders without the app layout or the catalog shell", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#bare-plate")
    assert has_element?(view, "#printer-name", "Itzel")
    assert html =~ "Oaxaca bare plate"
    assert html =~ "Cessna 182"
    refute html =~ "catalog-shell"
    refute html =~ "Get Started"
    refute html =~ "catalog-brand"
    assert html =~ "<html"
    assert html =~ "Phoenix Multivitamin"
  end
end

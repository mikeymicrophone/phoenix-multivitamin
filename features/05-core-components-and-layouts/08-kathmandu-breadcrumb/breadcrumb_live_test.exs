defmodule PhoenixMultivitaminWeb.KathmanduBreadcrumbLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/08-kathmandu-breadcrumb"

  test "the layout slot paints the station breadcrumb", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#station-crumb")
    assert has_element?(view, "#dispatcher-name", "Bina")
    assert html =~ "Kathmandu breadcrumb"
    assert html =~ "Harbin Y-12"
    assert html =~ "catalog-shell"
  end
end

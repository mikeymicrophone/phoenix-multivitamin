defmodule PhoenixMultivitaminWeb.CopenhagenCapstoneDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/13-copenhagen-capstone-desk"

  test "the desk ships catalog layout, core table, and a modal", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "catalog-shell"
    assert html =~ "Freja"
    assert html =~ "Airbus A220-300"
    assert has_element?(view, "#kastrup-stands")
    assert has_element?(view, "#a17")
    assert has_element?(view, "#b09")
    assert has_element?(view, "#hold-modal")
    assert has_element?(view, "#open-hold")
  end

  test "confirming the hold paints a flash through the layout", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_click(element(view, "#open-hold"))
    html = render_click(element(view, "#confirm-hold button"))
    assert html =~ "Freja held A17 for the A220-300"
    assert has_element?(view, "#flash-info")
  end
end

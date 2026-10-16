defmodule PhoenixMultivitaminWeb.JohannesburgQraTableLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/03-johannesburg-qra-table"

  test "the core table lists both Oryx pairs and the scramble button", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#qra-pairs")
    assert has_element?(view, "#oryx-1")
    assert has_element?(view, "#oryx-2")
    assert html =~ "Atlas Oryx"
    assert html =~ "Thandi"
    assert html =~ "table-zebra"
    assert has_element?(view, "#scramble-north")
    assert html =~ "btn-primary"
  end

  test "the core button posts the scramble without a custom class", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_click(element(view, "#scramble-north"))
    assert has_element?(view, "#scrambled-pad", "north")
  end
end

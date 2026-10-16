defmodule PhoenixMultivitaminWeb.OsloThemeDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/09-oslo-theme-desk"

  test "the theme toggle lives in the catalog nav, not the desk surface", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#controller-name", "Ingrid")
    assert has_element?(view, "#desk-surface", "night desk")
    assert html =~ "Boeing 737 MAX 8"
    assert html =~ ~s(data-phx-theme="system")
    assert html =~ ~s(data-phx-theme="light")
    assert html =~ ~s(data-phx-theme="dark")
    refute html =~ "#desk-surface" <> ~s( data-phx-theme)
    desk = LazyHTML.filter(LazyHTML.from_fragment(html), "#desk-surface")
    refute to_string(desk) =~ "data-phx-theme"
  end
end

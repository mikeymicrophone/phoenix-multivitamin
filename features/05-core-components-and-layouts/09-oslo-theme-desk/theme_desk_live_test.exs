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
    refute has_element?(view, "#desk-surface[data-phx-theme]")

    desk_html =
      html
      |> LazyHTML.from_document()
      |> LazyHTML.filter("#desk-surface")
      |> LazyHTML.to_html()

    refute desk_html =~ "data-phx-theme"
  end
end

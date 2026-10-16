defmodule PhoenixMultivitaminWeb.DuxfordHangarBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/05-core-components-and-layouts/01-duxford-hangar-board"
  @hangar @map <> "/hangar"

  test "the catalog card uses Layouts.catalog, not Layouts.app", %{conn: conn} do
    {:ok, view, html} = live(conn, @map)
    assert has_element?(view, "#open-app-hangar")
    assert html =~ "catalog-shell"
    assert html =~ "Phoenix Multivitamin"
    refute html =~ "Get Started"
    refute has_element?(view, "#app-surface")
  end

  test "the hangar path wraps the same LiveView in Layouts.app", %{conn: conn} do
    {:ok, view, html} = live(conn, @hangar)
    assert has_element?(view, "#app-surface", "App layout")
    assert html =~ "Get Started"
    assert html =~ "Gwendolen"
    assert html =~ "Hawker Hurricane"
    refute html =~ "catalog-shell"
  end
end

defmodule PhoenixMultivitaminWeb.MaryClassDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/05-mary-class-desk"

  test "add_class and remove_class target the vane", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Maral")
    assert html =~ "add_class"
    assert html =~ "remove_class"
    assert html =~ "hot-vane"
    assert html =~ "#merv-vane"
  end
end

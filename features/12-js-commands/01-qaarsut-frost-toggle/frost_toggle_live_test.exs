defmodule PhoenixMultivitaminWeb.QaarsutFrostToggleLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/01-qaarsut-frost-toggle"

  test "the frost button carries JS.toggle to the drawer", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Paniloo")
    assert has_element?(view, "#frost-drawer", "Rime on the S-76 blades.")
    assert html =~ "toggle"
    assert html =~ "#frost-drawer"
  end
end

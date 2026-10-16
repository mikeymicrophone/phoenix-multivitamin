defmodule PhoenixMultivitaminWeb.BukharaFogFlagLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/06-bukhara-fog-flag"

  test "set_attribute names the fog flag", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Nodira")
    assert html =~ "set_attr"
    assert html =~ "data-fog"
    assert html =~ "#fog-flag"
  end
end

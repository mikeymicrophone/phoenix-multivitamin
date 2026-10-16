defmodule PhoenixMultivitaminWeb.KutaisiLampFadeLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/03-kutaisi-lamp-fade"

  test "the fade button carries JS.transition", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Tamari")
    assert html =~ "transition"
    assert html =~ "fade-lamp"
    assert html =~ "#threshold-lamp"
  end
end

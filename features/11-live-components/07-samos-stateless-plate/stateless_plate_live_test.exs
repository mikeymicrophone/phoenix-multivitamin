defmodule PhoenixMultivitaminWeb.SamosStatelessPlateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/07-samos-stateless-plate"

  test "the stateless plate renders through an id", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Eleni")
    assert has_element?(view, "#plate-qnh", "1016")
    assert has_element?(view, "#samos-plate")
  end
end

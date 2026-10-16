defmodule PhoenixMultivitaminWeb.OshFilterResetLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/07-osh-filter-reset"

  test "reset: true drops Khujand after the east filter", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#leg-khujand", "Khujand")
    assert has_element?(view, "#leg-fergana", "Fergana")

    view |> element("#filter-east") |> render_click()
    assert has_element?(view, "#filter-name", "east")
    assert has_element?(view, "#leg-fergana", "Fergana")
    assert has_element?(view, "#leg-andijan", "Andijan")
    refute has_element?(view, "#leg-khujand")
  end
end

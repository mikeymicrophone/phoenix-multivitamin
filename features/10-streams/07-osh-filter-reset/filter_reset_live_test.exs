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

  test "an unsupported direction preserves the current legs", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    render_click(view, "filter_east", %{"kind" => "north"})

    assert has_element?(view, "#filter-name", "all")
    assert has_element?(view, "#leg-khujand")
    assert has_element?(view, "#flash-error")
  end

  test "the same filter callback can restore all legs", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> element("#filter-east") |> render_click()

    view |> element("#filter-all") |> render_click()

    assert has_element?(view, "#filter-name", "all")
    assert has_element?(view, "#leg-khujand")
  end
end

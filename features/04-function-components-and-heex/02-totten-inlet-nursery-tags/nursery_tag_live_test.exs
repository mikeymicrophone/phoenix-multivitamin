defmodule PhoenixMultivitaminWeb.TottenInletNurseryTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/02-totten-inlet-nursery-tags"

  test "inner_block, named mesh slots, and footer render on the Pacific bag", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Taylor Shellfish · Totten Inlet"
    assert html =~ "Nara"
    assert has_element?(view, "#pacific-bag-note", "slack water")
    assert has_element?(view, "#pacific-bag-meshes [data-mesh='6 mm']", "week 4")
    assert has_element?(view, "#pacific-bag-meshes [data-mesh='4 mm']", "week 7")
    refute has_element?(view, "#pacific-bag-meshes [data-mesh='3 mm']")
    assert has_element?(view, "#pacific-bag-grade", "18 seed per shell")
    assert has_element?(view, "#pacific-bag-grade", "Cull the boxy shells")
    assert has_element?(view, "#pacific-bag-footer", "Hauler Skookum")
  end

  test "an omitted footer slot renders the fallback, not an empty footer", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#olympia-bag-footer", "No hauler noted.")
    assert has_element?(view, "#olympia-bag-ungraded", "Not graded this pull.")
    refute has_element?(view, "#olympia-bag-grade")
  end

  test ":if on a named slot drops that entry from the slot list", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#hide-grading") |> render_click()
    assert has_element?(view, "#pacific-bag-ungraded", "Not graded this pull.")
    refute has_element?(view, "#pacific-bag-grade")

    view |> element("#show-grading") |> render_click()
    assert has_element?(view, "#pacific-bag-grade", "18 seed per shell")

    view |> element("#add-three-mill-mesh") |> render_click()
    assert has_element?(view, "#pacific-bag-meshes [data-mesh='3 mm']", "week 9")
  end
end

defmodule PhoenixMultivitaminWeb.SaoJoseEmbraerTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/02-sao-jose-embraer-tags"

  test "inner_block, named ply slots, and footer render on the wing tag", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Embraer · São José dos Campos"
    assert html =~ "Caio"
    assert has_element?(view, "#e175-wing-note", "south jig")
    assert has_element?(view, "#e175-wing-plies [data-ply='6 mm']", "week 4")
    assert has_element?(view, "#e175-wing-plies [data-ply='4 mm']", "week 7")
    refute has_element?(view, "#e175-wing-plies [data-ply='3 mm']")
    assert has_element?(view, "#e175-wing-grade", "18 fasteners per frame")
    assert has_element?(view, "#e175-wing-grade", "Cull the proud rivets")
    assert has_element?(view, "#e175-wing-footer", "Inspector desk")
  end

  test "an omitted footer slot renders the fallback, not an empty footer", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#e175-nose-footer", "No inspector noted.")
    assert has_element?(view, "#e175-nose-ungraded", "Not graded this bay.")
    refute has_element?(view, "#e175-nose-grade")
  end

  test ":if on a named slot drops that entry from the slot list", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#hide-grading") |> render_click()
    assert has_element?(view, "#e175-wing-ungraded", "Not graded this bay.")
    refute has_element?(view, "#e175-wing-grade")

    view |> element("#show-grading") |> render_click()
    assert has_element?(view, "#e175-wing-grade", "18 fasteners per frame")

    view |> element("#add-three-mill-ply") |> render_click()
    assert has_element?(view, "#e175-wing-plies [data-ply='3 mm']", "week 9")
  end
end

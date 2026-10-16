defmodule PhoenixMultivitaminWeb.BarentsburgCapstoneBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/13-barentsburg-capstone-board"

  test "toggle, transition, and push share one click", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Lars")
    assert html =~ "toggle"
    assert html =~ "transition"
    assert html =~ "log_grumant"

    view |> element("#open-grumant") |> render_click()
    assert has_element?(view, "#logged-grumant", "Grumant open")
  end
end

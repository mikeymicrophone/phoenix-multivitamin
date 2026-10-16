defmodule PhoenixMultivitaminWeb.TulceaPipeBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/10-tulcea-pipe-board"

  test "the piped command shows, classes, and pushes", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "show"
    assert html =~ "add_class"
    assert html =~ "mark_lit"

    view |> element("#pipe-delta") |> render_click()
    assert has_element?(view, "#marked-card", "lit")
  end
end

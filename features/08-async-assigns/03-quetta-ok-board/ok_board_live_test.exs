defmodule PhoenixMultivitaminWeb.QuettaOkBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/03-quetta-ok-board"

  test "the ok tuple fills QNH on the board", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Zarmina"
    assert has_element?(view, "#qnh-ok", "pending")

    html = render_async(view)
    assert html =~ "1019"
    assert has_element?(view, "#qnh-ok", "ok")
    assert has_element?(view, "#qnh-value", "1019")
    assert has_element?(view, "#craft-name", "Ilyushin Il-18")
  end
end

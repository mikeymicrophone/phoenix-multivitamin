defmodule PhoenixMultivitaminWeb.GomaAshTaskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/05-goma-ash-task"

  test "start_async fills a plain ash assign through handle_async", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Amani"
    assert has_element?(view, "#ash-pending")

    html = render_async(view)
    assert html =~ "Nyiragongo ash to FL180"
    assert has_element?(view, "#ash-line", "Nyiragongo ash to FL180")
    refute has_element?(view, "#ash-pending")
    assert has_element?(view, "#craft-name", "Mil Mi-8")
  end
end

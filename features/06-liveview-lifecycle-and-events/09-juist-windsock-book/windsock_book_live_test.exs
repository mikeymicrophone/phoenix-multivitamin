defmodule PhoenixMultivitaminWeb.JuistWindsockBookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/09-juist-windsock-book"

  test "send(self()) from the start click is applied after that event's render", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Juist Airfield"
    assert has_element?(view, "#marshal-name", "Hilde")
    assert has_element?(view, "#strike-count", "0")

    click_html = view |> element("#start-socks") |> render_click()

    assert click_html =~ "Sock strikes started on the Juist strip"
    refute click_html =~ "Sock struck, tally 1"
    assert click_html =~ "Strikes at event render"
    assert has_element?(view, "#event-html-strikes", "0")

    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#sock-state", "running")
    assert has_element?(view, "#strike-count", "1")
    assert has_element?(view, "#book-lines", "Sock struck, tally 1")
  end

  test "a later strike sent to the LiveView increments the tally", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#start-socks") |> render_click()
    _ = :sys.get_state(view.pid)

    send(view.pid, :strike_sock)
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#strike-count", "2")
    assert has_element?(view, "#book-lines", "Sock struck, tally 2")
  end

  test "stopping the socks ignores a late strike", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#start-socks") |> render_click()
    _ = :sys.get_state(view.pid)
    view |> element("#stop-socks") |> render_click()

    send(view.pid, :strike_sock)
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#sock-state", "quiet")
    assert has_element?(view, "#strike-count", "1")
    assert has_element?(view, "#book-lines", "Late strike ignored, socks already quiet")
  end
end

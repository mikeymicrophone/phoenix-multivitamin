defmodule PhoenixMultivitaminWeb.SlipPointBellBookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/09-slip-point-bell-book"

  test "send(self()) from the start click is applied after that event's render", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Slip Point Light"
    assert has_element?(view, "#keeper-name", "Willa")
    assert has_element?(view, "#strike-count", "0")

    click_html = view |> element("#start-bells") |> render_click()

    assert click_html =~ "Watch bells started on the Clallam Bay face"
    refute click_html =~ "Bell struck, tally 1"
    assert click_html =~ "Strikes at event render"
    assert has_element?(view, "#event-html-strikes", "0")

    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#bell-state", "running")
    assert has_element?(view, "#strike-count", "1")
    assert has_element?(view, "#book-lines", "Bell struck, tally 1")
  end

  test "a later strike sent to the LiveView increments the tally", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#start-bells") |> render_click()
    _ = :sys.get_state(view.pid)

    send(view.pid, :strike_bell)
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#strike-count", "2")
    assert has_element?(view, "#book-lines", "Bell struck, tally 2")
  end

  test "stopping the bells ignores a late strike", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#start-bells") |> render_click()
    _ = :sys.get_state(view.pid)
    view |> element("#stop-bells") |> render_click()

    send(view.pid, :strike_bell)
    _ = :sys.get_state(view.pid)

    assert has_element?(view, "#bell-state", "quiet")
    assert has_element?(view, "#strike-count", "1")
    assert has_element?(view, "#book-lines", "Late strike ignored, bells already quiet")
  end
end

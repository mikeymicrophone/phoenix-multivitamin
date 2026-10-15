defmodule PhoenixMultivitaminWeb.NewDungenessWatchLogLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/01-new-dungeness-watch-log"

  test "the disconnected mount keeps the watch clock quiet", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "New Dungeness Light Station"
    assert html =~ "Static mount. The watch clock stays quiet until the socket connects."
    assert html =~ "Maren"
    refute html =~ "Socket connected. Watch clock is armed on the connected mount."
  end

  test "the connected mount arms the clock and posts fog, tug, wick, and bell", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "New Dungeness Light Station"
    assert html =~ "Socket connected. Watch clock is armed on the connected mount."
    assert has_element?(view, "#clock-armed", "armed")
    assert has_element?(view, "#keeper-name", "Maren")
    assert has_element?(view, "#empty-log", "No lines posted this watch.")

    view |> element("#log-fog-bank") |> render_click()
    assert has_element?(view, "#watch-entries", "Fog bank over the spit")

    view |> element("#log-passing-tug") |> render_click()
    assert has_element?(view, "#watch-entries", "Cannery tender Retort")

    view |> element("#trim-wick") |> render_click()
    assert has_element?(view, "#watch-entries", "Lamp wick trimmed")

    view |> element("#strike-watch-bell") |> render_click()
    assert has_element?(view, "#watch-entries", "Watch bell struck")
    refute has_element?(view, "#empty-log")
  end

  test "handle_params switches the watch from the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#midwatch") |> render_click()

    assert_patch(view, @path <> "?watch=midwatch")
    assert has_element?(view, "#keeper-name", "Alden")
    assert has_element?(view, "#watch-name", "Midwatch")
    assert has_element?(view, "#station-clock", "00:00")
  end
end

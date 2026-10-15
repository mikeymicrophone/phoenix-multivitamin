defmodule PhoenixMultivitaminWeb.AlkiPointSignalFlagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.AlkiPointSignalFlagsLive

  @day_path "/features/02-verified-routes/01-alki-point-signal-flags"
  @night_path "/features/02-verified-routes/01-alki-point-signal-flags/night"

  test "the day board ~p path matches the router and renders the station", %{conn: conn} do
    assert AlkiPointSignalFlagsLive.day_board_path() == @day_path
    assert AlkiPointSignalFlagsLive.night_board_path() == @night_path
    assert ~p"/features/02-verified-routes/01-alki-point-signal-flags" == @day_path

    conn = get(conn, @day_path)
    html = html_response(conn, 200)

    assert html =~ "Alki Point Light"
    assert html =~ "Rhea"
    assert html =~ "Day board. Red and black pennants against the Sound."
    refute html =~ "Night board. The lantern gallery"
  end

  test "the night board is a second verified path on the same LiveView", %{conn: conn} do
    {:ok, view, html} = live(conn, @night_path)

    assert html =~ "Night board. The lantern gallery reads the same flags under the beam."
    assert has_element?(view, "#station-name", "Alki Point Light")
    assert has_element?(view, "#night-board-path", @night_path)
    assert has_element?(view, "#day-board-path", @day_path)
  end

  test "hoisting flags and navigating between boards keeps the verified paths", %{conn: conn} do
    {:ok, view, _html} = live(conn, @day_path)

    assert has_element?(view, "#flying-flag", "gale")

    view |> element("#hoist-storm") |> render_click()
    assert has_element?(view, "#flying-flag", "storm")
    assert has_element?(view, "#hoist-copy", "storm warning is flying on the day board")

    view |> element("#hoist-small-craft") |> render_click()
    assert has_element?(view, "#flying-flag", "small craft")

    {:ok, night_view, _html} =
      view
      |> element("#night-board-link")
      |> render_click()
      |> follow_redirect(conn, @night_path)

    assert has_element?(night_view, "#board-banner", "Night board")
    assert has_element?(night_view, "#day-board-link[href='#{@day_path}']")
  end
end

defmodule PhoenixMultivitaminWeb.AkureyriNightWatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/01-akureyri-night-watch"

  test "the disconnected mount keeps the watch clock quiet", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Akureyri Airport"
    assert html =~ "Static mount. The watch clock stays quiet until the socket connects."
    assert html =~ "Sólrún"
    refute html =~ "Socket connected. Watch clock is armed on the connected mount."
  end

  test "the connected mount arms the clock and posts ice, inbound, light, and ATIS", %{
    conn: conn
  } do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Akureyri Airport"
    assert html =~ "Socket connected. Watch clock is armed on the connected mount."
    assert has_element?(view, "#clock-armed", "armed")
    assert has_element?(view, "#controller-name", "Sólrún")
    assert has_element?(view, "#empty-log", "No lines posted this watch.")

    view |> element("#log-ice-pellets") |> render_click()
    assert has_element?(view, "#watch-entries", "Ice pellets on the apron")

    view |> element("#log-fokker-inbound") |> render_click()
    assert has_element?(view, "#watch-entries", "Fokker 50 inbound")

    view |> element("#trim-ice-light") |> render_click()
    assert has_element?(view, "#watch-entries", "Ice light trimmed")

    view |> element("#strike-atis-bell") |> render_click()
    assert has_element?(view, "#watch-entries", "ATIS bell struck")
    refute has_element?(view, "#empty-log")
  end

  test "handle_params switches the watch from the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#midwatch") |> render_click()

    assert_patch(view, @path <> "?watch=midwatch")
    assert has_element?(view, "#controller-name", "Egill")
    assert has_element?(view, "#watch-name", "Midwatch")
    assert has_element?(view, "#station-clock", "00:00")
  end
end

defmodule PhoenixMultivitaminWeb.KalamaElevatorTapeTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/01-routing-and-plugs/06-kalama-elevator-tape"
  @tape @map <> "/tape"
  @silo @map <> "/silo"

  test "the controller tape reads the pipeline shift assign directly", %{conn: conn} do
    conn = get(conn, @tape <> "?shift=swing")
    html = html_response(conn, 200)

    assert html =~ "Kalama export elevator"
    assert html =~ "swing"
    assert html =~ "Rhea"
  end

  test "the catalog LiveView has no pipeline shift, so assign_new uses the fallback", %{
    conn: conn
  } do
    conn = get(conn, @map)
    html = html_response(conn, 200)

    assert html =~ "no shift from the plug"
    assert html =~ "The socket had no shift key until assign_new/3."
    refute html =~ "Kalama export elevator"
  end

  test "the silo LiveView copies the plug assign through assign_new/3 without putting it on the socket first",
       %{conn: conn} do
    conn = get(conn, @silo <> "?shift=day")
    html = html_response(conn, 200)

    assert html =~ "day"
    assert html =~ "Kalama export elevator"
    assert html =~ "The socket had no shift key until assign_new/3."
    refute html =~ "no shift from the plug"
  end

  test "the connected silo still shows the copied shift", %{conn: conn} do
    {:ok, view, html} = live(conn, @silo)

    assert html =~ "graveyard"
    assert has_element?(view, "#socket-had-shift", "no")
    assert has_element?(view, "#shift-name", "graveyard")
  end
end

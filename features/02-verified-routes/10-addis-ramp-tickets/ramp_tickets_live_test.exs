defmodule PhoenixMultivitaminWeb.AddisRampTicketsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.AddisRampTicketsLive

  @board "/features/02-verified-routes/10-addis-ramp-tickets"
  @lane_two "/features/02-verified-routes/10-addis-ramp-tickets/kiosk/lane/2"

  test "the main router ~p includes the forwarded kiosk prefix" do
    assert AddisRampTicketsLive.board_path() == @board
    assert AddisRampTicketsLive.lane_path(2) == @lane_two

    assert AddisRampTicketsLive.lane_path("3") ==
             "/features/02-verified-routes/10-addis-ramp-tickets/kiosk/lane/3"
  end

  test "the kiosk ~p is unprefixed; path(conn, ~p) adds script_name", %{conn: conn} do
    conn = get(conn, @lane_two)
    html = html_response(conn, 200)

    assert html =~ "Lane 2 ticket window"
    assert html =~ ~s(id="local-kiosk-path">/lane/2<)

    assert html =~
             ~s(id="prefixed-kiosk-path">/features/02-verified-routes/10-addis-ramp-tickets/kiosk/lane/2<)

    assert html =~ ~s(id="script-name">features/02-verified-routes/10-addis-ramp-tickets/kiosk<)
  end

  test "the ramp board links through the verified kiosk prefix", %{conn: conn} do
    {:ok, view, html} = live(conn, @board)

    assert html =~ "Addis Ababa Bole ramp"
    assert html =~ "Selam"
    assert has_element?(view, "#lane-two-path", @lane_two)
    assert has_element?(view, "#open-lane-two[href='#{@lane_two}']")
  end
end

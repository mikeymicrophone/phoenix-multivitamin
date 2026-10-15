defmodule PhoenixMultivitaminWeb.PointRobinsonBellRelayLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import Swoosh.TestAssertions

  alias PhoenixMultivitaminWeb.PointRobinsonBellRelayLive
  alias PhoenixMultivitaminWeb.PointRobinsonBellRelayMailer

  @path "/features/02-verified-routes/09-point-robinson-bell-relay"
  @board_url PhoenixMultivitaminWeb.Endpoint.url() <> @path

  test "the mailer puts url(~p) in both HTML and text bodies" do
    assert PointRobinsonBellRelayMailer.board_url() == @board_url
    assert PointRobinsonBellRelayLive.board_path() == @path

    {:ok, email} =
      PointRobinsonBellRelayMailer.deliver_bell_watch("Leda", "leda@pointrobinson.wa.gov")

    assert email.to == [{"Leda", "leda@pointrobinson.wa.gov"}]
    assert email.from == {"Point Robinson Light", "bell@pointrobinson.wa.gov"}
    assert email.subject == "Bell watch for Leda"
    assert email.text_body == "The bell watch is posted at #{@board_url}"
    assert email.html_body =~ ~s(href="#{@board_url}")
    assert email.html_body =~ "Strike once at the quarter for Maury Island"
  end

  test "relaying the watch from the board delivers the mailer", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Point Robinson Light"
    assert has_element?(view, "#keeper-name", "Leda")
    assert has_element?(view, "#board-url", @board_url)
    assert has_element?(view, "#last-relay", "none")

    view |> element("#relay-watch") |> render_click()
    assert has_element?(view, "#last-relay", "Bell watch for Leda")

    assert_email_sent(fn email ->
      assert email.subject == "Bell watch for Leda"
      assert email.html_body =~ @board_url
    end)
  end
end

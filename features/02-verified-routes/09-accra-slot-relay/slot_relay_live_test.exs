defmodule PhoenixMultivitaminWeb.AccraSlotRelayLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import Swoosh.TestAssertions

  alias PhoenixMultivitaminWeb.AccraSlotRelayLive
  alias PhoenixMultivitaminWeb.AccraSlotRelayMailer

  @path "/features/02-verified-routes/09-accra-slot-relay"
  @board_url PhoenixMultivitaminWeb.Endpoint.url() <> @path

  test "the mailer puts url(~p) in both HTML and text bodies" do
    assert AccraSlotRelayMailer.board_url() == @board_url
    assert AccraSlotRelayLive.board_path() == @path

    {:ok, email} =
      AccraSlotRelayMailer.deliver_slot_watch("Kwame", "kwame@kotoka.gov.gh")

    assert email.to == [{"Kwame", "kwame@kotoka.gov.gh"}]
    assert email.from == {"Accra Kotoka slot board", "slots@kotoka.gov.gh"}
    assert email.subject == "Slot watch for Kwame"
    assert email.text_body == "The slot watch is posted at #{@board_url}"
    assert email.html_body =~ ~s(href="#{@board_url}")
    assert email.html_body =~ "Hold the 777-300ER at the quarter for Kotoka"
  end

  test "relaying the watch from the board delivers the mailer", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Accra Kotoka slot board"
    assert has_element?(view, "#clerk-name", "Kwame")
    assert has_element?(view, "#board-url", @board_url)
    assert has_element?(view, "#last-relay", "none")

    view |> element("#relay-watch") |> render_click()
    assert has_element?(view, "#last-relay", "Slot watch for Kwame")

    assert_email_sent(fn email ->
      assert email.subject == "Slot watch for Kwame"
      assert email.html_body =~ @board_url
    end)
  end
end

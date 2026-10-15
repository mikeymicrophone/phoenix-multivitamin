defmodule PhoenixMultivitaminWeb.FortWordenGuardHouseLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import Swoosh.TestAssertions

  alias PhoenixMultivitaminWeb.FortWordenGuardHouseController
  alias PhoenixMultivitaminWeb.FortWordenGuardHouseLive
  alias PhoenixMultivitaminWeb.FortWordenGuardHouseMailer

  @board "/features/02-verified-routes/13-fort-worden-guard-house"
  @gate "/features/02-verified-routes/13-fort-worden-guard-house/gate"
  @relief "/features/02-verified-routes/13-fort-worden-guard-house/relief"
  @kinzie "/features/02-verified-routes/13-fort-worden-guard-house/passes/kinzie"
  @board_url PhoenixMultivitaminWeb.Endpoint.url() <> @board

  test "controller, LiveView, and mailer share the board ~p" do
    assert FortWordenGuardHouseLive.board_path() == @board
    assert FortWordenGuardHouseController.gate_path() == @gate
    assert FortWordenGuardHouseLive.relief_path() == @relief
    assert FortWordenGuardHouseLive.pass_path("kinzie") == @kinzie
    assert FortWordenGuardHouseMailer.board_url() == @board_url

    assert FortWordenGuardHouseMailer.pass_url("kinzie") ==
             PhoenixMultivitaminWeb.Endpoint.url() <> @kinzie
  end

  test "the gate controller redirects onto the verified board with query params", %{conn: conn} do
    conn = get(conn, @gate)
    assert redirected_to(conn) == "#{@board}?gate=open&watch=evening"
  end

  test "the mailer HTML cites both the board URL and the pass URL" do
    {:ok, email} =
      FortWordenGuardHouseMailer.deliver_pass(
        "Corin",
        "corin@fortworden.wa.gov",
        "kinzie"
      )

    assert email.subject == "Battery kinzie pass for Corin"
    assert email.html_body =~ ~s(href="#{@board_url}")
    assert email.html_body =~ ~s(href="#{PhoenixMultivitaminWeb.Endpoint.url() <> @kinzie}")
    assert email.text_body =~ @board_url
  end

  test "patch keeps the socket; navigate and the issued pass remount", %{conn: conn} do
    {:ok, view, html} = live(conn, @board)

    assert html =~ "Fort Worden guard house"
    assert has_element?(view, "#sentry-name", "Corin")
    assert has_element?(view, "#watch-name", "day")
    assert has_element?(view, "#gate-state", "shut")
    assert has_element?(view, "#plate-path", "/images/logo.svg")
    assert has_element?(view, "#guard-plate[src='/images/logo.svg']")
    assert has_element?(view, "#board-url", @board_url)
    assert has_element?(view, "#mount-count", "1")

    view |> element("#patch-evening") |> render_click()
    assert_patch(view, "#{@board}?watch=evening")
    assert has_element?(view, "#watch-name", "evening")
    assert has_element?(view, "#mount-count", "1")

    {:ok, relief_view, _html} =
      view
      |> element("#navigate-relief")
      |> render_click()
      |> follow_redirect(conn, @relief)

    assert has_element?(relief_view, "#surface-name", "relief")
    assert has_element?(relief_view, "#surface-banner", "Relief walk")
    assert has_element?(relief_view, "#mount-count", "1")
  end

  test "issuing a Kinzie pass mails Corin and navigates to the pass card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @board)

    {:ok, pass_view, _html} =
      view
      |> element("#issue-kinzie")
      |> render_click()
      |> follow_redirect(conn, @kinzie)

    assert has_element?(pass_view, "#pass-name", "kinzie")
    assert has_element?(pass_view, "#surface-name", "pass")
    assert has_element?(pass_view, "#surface-banner", "Battery Kinzie")

    assert_email_sent(fn email ->
      assert email.to == [{"Corin", "corin@fortworden.wa.gov"}]
      assert email.html_body =~ @board_url
      assert email.html_body =~ "kinzie"
    end)
  end

  test "opening the gate lands on evening watch with the gate open", %{conn: conn} do
    conn = get(conn, @gate)
    {:ok, view, _html} = live(conn, redirected_to(conn))

    assert has_element?(view, "#watch-name", "evening")
    assert has_element?(view, "#gate-state", "open")
    assert has_element?(view, "#post-copy", "gate open")
  end
end

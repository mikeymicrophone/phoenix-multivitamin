defmodule PhoenixMultivitaminWeb.LuqaQraGuardHouseLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest
  import Swoosh.TestAssertions

  alias PhoenixMultivitaminWeb.LuqaQraGuardHouseController
  alias PhoenixMultivitaminWeb.LuqaQraGuardHouseLive
  alias PhoenixMultivitaminWeb.LuqaQraGuardHouseMailer

  @board "/features/02-verified-routes/13-luqa-qra-guard-house"
  @gate "/features/02-verified-routes/13-luqa-qra-guard-house/gate"
  @relief "/features/02-verified-routes/13-luqa-qra-guard-house/relief"
  @qra "/features/02-verified-routes/13-luqa-qra-guard-house/passes/qra"
  @board_url PhoenixMultivitaminWeb.Endpoint.url() <> @board

  test "controller, LiveView, and mailer share the board ~p" do
    assert LuqaQraGuardHouseLive.board_path() == @board
    assert LuqaQraGuardHouseController.gate_path() == @gate
    assert LuqaQraGuardHouseLive.relief_path() == @relief
    assert LuqaQraGuardHouseLive.pass_path("qra") == @qra
    assert LuqaQraGuardHouseMailer.board_url() == @board_url

    assert LuqaQraGuardHouseMailer.pass_url("qra") ==
             PhoenixMultivitaminWeb.Endpoint.url() <> @qra
  end

  test "the gate controller redirects onto the verified board with query params", %{conn: conn} do
    conn = get(conn, @gate)
    assert redirected_to(conn) == "#{@board}?gate=open&watch=evening"
  end

  test "the mailer HTML cites both the board URL and the pass URL" do
    {:ok, email} =
      LuqaQraGuardHouseMailer.deliver_pass(
        "Luca",
        "luca@luqa.gov.mt",
        "qra"
      )

    assert email.subject == "Hangar qra pass for Luca"
    assert email.html_body =~ ~s(href="#{@board_url}")
    assert email.html_body =~ ~s(href="#{PhoenixMultivitaminWeb.Endpoint.url() <> @qra}")
    assert email.text_body =~ @board_url
  end

  test "patch keeps the socket; navigate and the issued pass remount", %{conn: conn} do
    {:ok, view, html} = live(conn, @board)

    assert html =~ "Luqa QRA guard house"
    assert has_element?(view, "#guard-name", "Luca")
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

  test "issuing a QRA pass mails Luca and navigates to the pass card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @board)

    {:ok, pass_view, _html} =
      view
      |> element("#issue-qra")
      |> render_click()
      |> follow_redirect(conn, @qra)

    assert has_element?(pass_view, "#pass-name", "qra")
    assert has_element?(pass_view, "#surface-name", "pass")
    assert has_element?(pass_view, "#surface-banner", "Hangar QRA")

    assert_email_sent(fn email ->
      assert email.to == [{"Luca", "luca@luqa.gov.mt"}]
      assert email.html_body =~ @board_url
      assert email.html_body =~ "qra"
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

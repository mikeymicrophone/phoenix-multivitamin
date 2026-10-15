defmodule PhoenixMultivitaminWeb.WestPointCurrentCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.WestPointCurrentCardController
  alias PhoenixMultivitaminWeb.WestPointCurrentCardLive

  @card "/features/02-verified-routes/05-west-point-current-card"
  @drift "/features/02-verified-routes/05-west-point-current-card/drift"

  test "the drift calculator redirects to a verified card path with query params", %{conn: conn} do
    assert WestPointCurrentCardController.drift_path() == @drift
    assert WestPointCurrentCardLive.card_path() == @card

    conn = get(conn, @drift)
    assert redirected_to(conn) == "#{@card}?knots=1.4&set=ebb"
  end

  test "the card reads the redirected set and knots", %{conn: conn} do
    {:ok, view, html} = live(conn, "#{@card}?knots=1.4&set=ebb")

    assert html =~ "West Point Light"
    assert html =~ "Ivo"
    assert has_element?(view, "#current-set", "ebb")
    assert has_element?(view, "#current-knots", "1.4")
    assert has_element?(view, "#current-copy", "ebb at 1.4 kn")
    assert has_element?(view, "#drift-path", @drift)
    assert has_element?(view, "#run-drift[href='#{@drift}']")
  end

  test "the card defaults to flood until the calculator runs", %{conn: conn} do
    {:ok, view, _html} = live(conn, @card)

    assert has_element?(view, "#current-set", "flood")
    assert has_element?(view, "#current-knots", "0.8")
  end
end

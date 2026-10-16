defmodule PhoenixMultivitaminWeb.FunchalWindCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.FunchalWindCardController
  alias PhoenixMultivitaminWeb.FunchalWindCardLive

  @card "/features/02-verified-routes/05-funchal-wind-card"
  @drift "/features/02-verified-routes/05-funchal-wind-card/drift"

  test "the drift calculator redirects to a verified card path with query params", %{conn: conn} do
    assert FunchalWindCardController.drift_path() == @drift
    assert FunchalWindCardLive.card_path() == @card

    conn = get(conn, @drift)
    assert redirected_to(conn) == "#{@card}?knots=18&set=cross"
  end

  test "the card reads the redirected set and knots", %{conn: conn} do
    {:ok, view, html} = live(conn, "#{@card}?knots=18&set=cross")

    assert html =~ "Funchal wind card"
    assert html =~ "Rui"
    assert has_element?(view, "#wind-set", "cross")
    assert has_element?(view, "#wind-knots", "18")
    assert has_element?(view, "#wind-copy", "cross at 18 kn")
    assert has_element?(view, "#drift-path", @drift)
    assert has_element?(view, "#run-drift[href='#{@drift}']")
  end

  test "the card defaults to head until the calculator runs", %{conn: conn} do
    {:ok, view, _html} = live(conn, @card)

    assert has_element?(view, "#wind-set", "head")
    assert has_element?(view, "#wind-knots", "12")
  end
end

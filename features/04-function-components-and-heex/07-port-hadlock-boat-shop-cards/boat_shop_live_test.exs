defmodule PhoenixMultivitaminWeb.PortHadlockBoatShopCardsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/07-port-hadlock-boat-shop-cards"

  test "render_slot/2 yields the station into :let", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Port Hadlock"
    assert html =~ "Kerr"
    assert has_element?(view, "#yield-card-yield", "white oak")
    assert has_element?(view, "#yield-card-yield", "7/8 in")
    assert has_element?(view, "#yield-card-yield", "midship")
    assert has_element?(view, "#yield-card-varnish", "Epifanes")
  end

  test "render_slot/1 with no argument binds nil to :let", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#nil-card-yield", "no station yielded")
    refute has_element?(view, "#nil-card-yield", "got a station")
    assert has_element?(view, "#nil-card-varnish", "No varnish scheduled this week.")
  end

  test "moving station updates the yielded map and skipping varnish uses the fallback", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#move-to-stem") |> render_click()
    assert has_element?(view, "#yield-card-yield", "purpleheart")
    assert has_element?(view, "#yield-card-yield", "stem")

    view |> element("#skip-varnish") |> render_click()
    assert has_element?(view, "#yield-card-varnish", "No varnish scheduled this week.")
    refute has_element?(view, "#yield-card-varnish", "Epifanes")
  end
end

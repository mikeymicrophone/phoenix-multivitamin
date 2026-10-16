defmodule PhoenixMultivitaminWeb.HahnweideWorkCardsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/07-hahnweide-work-cards"

  test "render_slot/2 yields the station into :let", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Hahnweide"
    assert html =~ "Jutta"
    assert has_element?(view, "#yield-card-yield", "spruce")
    assert has_element?(view, "#yield-card-yield", "7/8 in")
    assert has_element?(view, "#yield-card-yield", "rib")
    assert has_element?(view, "#yield-card-dope", "nitrate")
  end

  test "render_slot/1 with no argument binds nil to :let", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#nil-card-yield", "no station yielded")
    refute has_element?(view, "#nil-card-yield", "got a station")
    assert has_element?(view, "#nil-card-dope", "No dope scheduled this week.")
  end

  test "moving station updates the yielded map and skipping dope uses the fallback", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#move-to-leading-edge") |> render_click()
    assert has_element?(view, "#yield-card-yield", "ash")
    assert has_element?(view, "#yield-card-yield", "leading-edge")

    view |> element("#skip-dope") |> render_click()
    assert has_element?(view, "#yield-card-dope", "No dope scheduled this week.")
    refute has_element?(view, "#yield-card-dope", "nitrate")
  end
end

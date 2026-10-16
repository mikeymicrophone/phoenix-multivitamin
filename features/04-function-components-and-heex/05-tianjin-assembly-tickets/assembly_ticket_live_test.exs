defmodule PhoenixMultivitaminWeb.TianjinAssemblyTicketsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/05-tianjin-assembly-tickets"

  test "the rest default class prints when the caller omits class", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Airbus Final Assembly · Tianjin"
    assert html =~ "Wei"
    assert has_element?(view, "#fuselage-ticket")
    assert has_element?(view, "#wing-ticket", "4820")
    fuselage = view |> element("#fuselage-ticket") |> render()
    assert fuselage =~ "join-ticket"
    empennage = view |> element("#empennage-ticket") |> render()
    assert empennage =~ "bay-slip"
    refute empennage =~ "join-ticket"
  end

  test "a caller class replaces the rest default class instead of concatenating", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#mark-wing-rush") |> render_click()
    class = view |> element("#wing-ticket") |> render()
    assert class =~ "rush-load"
    refute class =~ "join-ticket"

    view |> element("#clear-wing-rush") |> render_click()
    class = view |> element("#wing-ticket") |> render()
    refute class =~ "rush-load"
    assert class =~ "join-ticket"
  end

  test "included global attrs such as disabled pass through rest", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ ~s(data-bunk="three")
    refute has_element?(view, "#fuselage-ticket[disabled]")

    view |> element("#hold-fuselage-ticket") |> render_click()
    assert has_element?(view, "#fuselage-ticket[disabled]")
  end
end

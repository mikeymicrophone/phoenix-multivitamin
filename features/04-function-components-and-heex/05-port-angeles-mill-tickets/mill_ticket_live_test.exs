defmodule PhoenixMultivitaminWeb.PortAngelesMillTicketsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/05-port-angeles-mill-tickets"

  test "the rest default class prints when the caller omits class", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Interfor · Port Angeles"
    assert html =~ "Edie"
    assert has_element?(view, "#fir-ticket")
    assert has_element?(view, "#hemlock-ticket", "4820")
    fir = view |> element("#fir-ticket") |> render()
    assert fir =~ "mill-ticket"
    cedar = view |> element("#cedar-ticket") |> render()
    assert cedar =~ "scale-slip"
    refute cedar =~ "mill-ticket"
  end

  test "a caller class replaces the rest default class instead of concatenating", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#mark-hemlock-rush") |> render_click()
    class = view |> element("#hemlock-ticket") |> render()
    assert class =~ "rush-load"
    refute class =~ "mill-ticket"

    view |> element("#clear-hemlock-rush") |> render_click()
    class = view |> element("#hemlock-ticket") |> render()
    refute class =~ "rush-load"
    assert class =~ "mill-ticket"
  end

  test "included global attrs such as disabled pass through rest", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ ~s(data-bunk="three")
    refute has_element?(view, "#fir-ticket[disabled]")

    view |> element("#hold-fir-ticket") |> render_click()
    assert has_element?(view, "#fir-ticket[disabled]")
  end
end

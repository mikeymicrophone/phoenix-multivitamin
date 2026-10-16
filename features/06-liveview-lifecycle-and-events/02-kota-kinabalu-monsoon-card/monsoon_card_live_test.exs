defmodule PhoenixMultivitaminWeb.KotaKinabaluMonsoonCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/02-kota-kinabalu-monsoon-card"

  test "phx-value attributes arrive as strings, hyphens and all", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Kota Kinabalu International"
    assert has_element?(view, "#controller-name", "Farah")
    assert has_element?(view, "#empty-card")

    view |> element("#two-cells") |> render_click()

    assert has_element?(view, "#posted-mode", "two-cells")
    assert has_element?(view, "#period-payload", "15")
    assert has_element?(view, "#period-is-binary", "yes")
    assert has_element?(view, "#cells-payload", "2")
    assert has_element?(view, "#cells-is-binary", "yes")
    assert has_element?(view, "#card-lines", "Two cells on the weather radar, 15s apart")
    refute has_element?(view, "#empty-card")
  end

  test "a click with no phx-value posts clear from an empty map", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#clear-mode") |> render_click()

    assert has_element?(view, "#posted-mode", "clear")
    assert has_element?(view, "#period-payload", "—")
    assert has_element?(view, "#card-lines", "Monsoon card cleared")
  end

  test "a second mode replaces the posted card line", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#two-cells") |> render_click()
    view |> element("#one-cell") |> render_click()

    assert has_element?(view, "#posted-mode", "one-cell")
    assert has_element?(view, "#card-lines", "One cell on the weather radar every 10s")
    assert has_element?(view, "#period-payload", "10")
  end
end

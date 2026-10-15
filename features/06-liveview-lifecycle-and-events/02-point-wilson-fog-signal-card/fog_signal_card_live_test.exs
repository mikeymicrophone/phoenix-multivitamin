defmodule PhoenixMultivitaminWeb.PointWilsonFogSignalCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/02-point-wilson-fog-signal-card"

  test "phx-value attributes arrive as strings, hyphens and all", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Point Wilson Light"
    assert has_element?(view, "#keeper-name", "Evander")
    assert has_element?(view, "#empty-card")

    view |> element("#two-blasts") |> render_click()

    assert has_element?(view, "#posted-characteristic", "two-blasts")
    assert has_element?(view, "#period-payload", "15")
    assert has_element?(view, "#period-is-binary", "yes")
    assert has_element?(view, "#blasts-payload", "2")
    assert has_element?(view, "#blasts-is-binary", "yes")
    assert has_element?(view, "#card-lines", "Two blasts on the diaphone, 15s apart")
    refute has_element?(view, "#empty-card")
  end

  test "a click with no phx-value posts silence from an empty map", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#silence-signal") |> render_click()

    assert has_element?(view, "#posted-characteristic", "silence")
    assert has_element?(view, "#period-payload", "—")
    assert has_element?(view, "#card-lines", "Fog signal silenced")
  end

  test "a second characteristic replaces the posted card line", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#two-blasts") |> render_click()
    view |> element("#one-blast") |> render_click()

    assert has_element?(view, "#posted-characteristic", "one-blast")
    assert has_element?(view, "#card-lines", "One blast on the diaphone every 10s")
    assert has_element?(view, "#period-payload", "10")
  end
end

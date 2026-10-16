defmodule PhoenixMultivitaminWeb.KeflavikJetstreamTableLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/08-keflavik-jetstream-table"

  test "the markup keeps phx-throttle for the browser", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Keflavik"
    assert has_element?(view, "#reach-name", "Polar reach")
    assert html =~ ~s(phx-throttle="2000")
  end

  test "two rapid clicks both count because LiveViewTest does not throttle", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#plus-knot") |> render_click()
    view |> element("#plus-knot") |> render_click()

    assert has_element?(view, "#knot-count", "2")
    assert has_element?(view, "#click-count", "2")
    assert has_element?(view, "#table-lines", "2 kn on the Polar reach")
  end

  test "handle_params switches the reach from the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#plus-knot") |> render_click()
    view |> element("#atlantic-reach") |> render_click()

    assert_patch(view, @path <> "?reach=atlantic")
    assert has_element?(view, "#reach-name", "Atlantic reach")
    assert has_element?(view, "#core-set", "shear along the coast")
    assert has_element?(view, "#knot-count", "1")
  end
end

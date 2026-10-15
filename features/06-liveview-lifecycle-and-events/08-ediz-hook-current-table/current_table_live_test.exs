defmodule PhoenixMultivitaminWeb.EdizHookCurrentTableLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/08-ediz-hook-current-table"

  test "the markup keeps phx-throttle for the browser", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Ediz Hook"
    assert has_element?(view, "#reach-name", "Ediz Hook reach")
    assert html =~ ~s(phx-throttle="2000")
  end

  test "two rapid clicks both count because LiveViewTest does not throttle", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#plus-knot") |> render_click()
    view |> element("#plus-knot") |> render_click()

    assert has_element?(view, "#knot-count", "2")
    assert has_element?(view, "#click-count", "2")
    assert has_element?(view, "#table-lines", "2 kn on the Ediz Hook reach")
  end

  test "handle_params switches the reach from the URL", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#plus-knot") |> render_click()
    view |> element("#harbor-reach") |> render_click()

    assert_patch(view, @path <> "?reach=harbor")
    assert has_element?(view, "#reach-name", "Port Angeles harbor")
    assert has_element?(view, "#flood-set", "eddy along the mill")
    assert has_element?(view, "#knot-count", "1")
  end
end

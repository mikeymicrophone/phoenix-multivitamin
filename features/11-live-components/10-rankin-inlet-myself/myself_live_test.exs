defmodule PhoenixMultivitaminWeb.RankinInletMyselfLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/10-rankin-inlet-myself"

  test "myself stays in the cell and self() reaches the parent", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-stamp", "none")
    assert has_element?(view, "#parent-heard", "quiet")

    view |> element("#stamp-self") |> render_click()
    assert has_element?(view, "#cell-stamp", "myself")
    assert has_element?(view, "#parent-heard", "quiet")

    view |> element("#ping-parent") |> render_click()
    assert has_element?(view, "#parent-heard", "heard")
  end
end

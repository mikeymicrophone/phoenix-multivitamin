defmodule PhoenixMultivitaminWeb.LaeAssignSplitLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/11-lae-assign-split"

  test "a pad swing does not reset the cell taps", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> element("#tap-cell") |> render_click()
    assert has_element?(view, "#cell-taps", "1")
    assert has_element?(view, "#cell-pad", "north")

    view |> element("#swing-south") |> render_click()
    assert has_element?(view, "#cell-pad", "south")
    assert has_element?(view, "#cell-taps", "1")
  end
end

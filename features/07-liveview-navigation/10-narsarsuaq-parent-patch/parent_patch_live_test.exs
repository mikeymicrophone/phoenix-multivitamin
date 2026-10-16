defmodule PhoenixMultivitaminWeb.NarsarsuaqParentPatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @board "/features/07-liveview-navigation/10-narsarsuaq-parent-patch"
  @east @board <> "/pads/east"

  test "a back patch returns to the parent board without remounting", %{conn: conn} do
    {:ok, view, _html} = live(conn, @board)
    assert has_element?(view, "#clerk-name", "Naja")
    assert has_element?(view, "#surface-name", "board")
    assert has_element?(view, "#pad-name", "none")

    view |> element("#open-east-pad") |> render_click()
    assert_patch(view, @east)
    assert has_element?(view, "#surface-name", "pad")
    assert has_element?(view, "#pad-name", "east")
    assert has_element?(view, "#mount-count", "1")

    view |> element("#back-to-board") |> render_click()
    assert_patch(view, @board)
    assert has_element?(view, "#surface-name", "board")
    assert has_element?(view, "#pad-name", "none")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#craft-name", "Dash 7")
  end
end

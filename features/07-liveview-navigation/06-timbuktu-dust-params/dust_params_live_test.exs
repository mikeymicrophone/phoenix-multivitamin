defmodule PhoenixMultivitaminWeb.TimbuktuDustParamsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/06-timbuktu-dust-params"

  test "handle_params after mount is :mount; a later patch is :patch", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aissata")
    assert has_element?(view, "#params-via", "mount")
    assert has_element?(view, "#params-runs", "1")
    assert has_element?(view, "#lane-name", "harmattan")

    view |> element("#patch-sahel") |> render_click()
    assert_patch(view, @path <> "?lane=sahel")
    assert has_element?(view, "#params-via", "patch")
    assert has_element?(view, "#params-runs", "2")
    assert has_element?(view, "#lane-name", "sahel")
    assert has_element?(view, "#craft-name", "CASA C-212")
  end
end

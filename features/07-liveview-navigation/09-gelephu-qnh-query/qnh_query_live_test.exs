defmodule PhoenixMultivitaminWeb.GelephuQnhQueryLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/09-gelephu-qnh-query"

  test "QNH in the query string survives a watch patch", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path <> "?qnh=1021&watch=morning")
    assert has_element?(view, "#clerk-name", "Pema")
    assert has_element?(view, "#qnh-value", "1021")
    assert has_element?(view, "#watch-name", "morning")

    view |> element("#patch-evening") |> render_click()
    assert_patch(view, @path <> "?qnh=1021&watch=evening")
    assert has_element?(view, "#qnh-value", "1021")
    assert has_element?(view, "#watch-name", "evening")
    assert has_element?(view, "#craft-name", "Dornier 228")
  end
end

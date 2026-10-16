defmodule PhoenixMultivitaminWeb.RioGrandeFuegianWatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @watch "/features/07-liveview-navigation/13-rio-grande-fuegian-watch"
  @relief @watch <> "/relief"

  test "a patch keeps clicks; navigate opens relief as a new LiveView", %{conn: conn} do
    {:ok, view, _html} = live(conn, @watch)
    assert has_element?(view, "#clerk-name", "Belén")
    assert has_element?(view, "#watch-name", "evening")

    view |> element("#log-click") |> render_click()
    view |> element("#patch-midwatch") |> render_click()
    assert_patch(view, @watch <> "?watch=midwatch")
    assert has_element?(view, "#watch-name", "midwatch")
    assert has_element?(view, "#watch-clicks", "1")
    assert has_element?(view, "#mount-count", "1")

    {:ok, relief, _html} =
      view
      |> element("#open-relief")
      |> render_click()
      |> follow_redirect(conn, @relief)

    assert has_element?(relief, "#surface-name", "relief")
    assert has_element?(relief, "#relief-clicks", "0")
    assert has_element?(relief, "#craft-name", "Beech 1900")
  end
end

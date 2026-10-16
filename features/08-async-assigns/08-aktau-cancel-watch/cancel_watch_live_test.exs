defmodule PhoenixMultivitaminWeb.AktauCancelWatchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/08-aktau-cancel-watch"

  test "patching the watch cancels the evening METAR and fills midwatch", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aigerim")
    assert has_element?(view, "#watch-name", "evening")
    assert has_element?(view, "#metar-loading")

    view |> element("#patch-midwatch") |> render_click()
    assert_patch(view, @path <> "?watch=midwatch")
    html = render_async(view)
    assert html =~ "midwatch 25012KT"
    assert has_element?(view, "#metar-value", "midwatch 25012KT")
    refute has_element?(view, "#metar-value", "evening late")
    assert has_element?(view, "#craft-name", "Antonov An-24")
  end
end

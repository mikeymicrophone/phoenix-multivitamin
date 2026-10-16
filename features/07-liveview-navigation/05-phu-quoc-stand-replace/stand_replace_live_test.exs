defmodule PhoenixMultivitaminWeb.PhuQuocStandReplaceLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/05-phu-quoc-stand-replace"

  test "replace: true still patches the stand through handle_params", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Linh")
    assert has_element?(view, "#stand-name", "a3")
    assert has_element?(view, "#replace-flag", "replace")

    view |> element("#replace-b7") |> render_click()
    assert_patch(view, @path <> "?stand=b7")
    assert has_element?(view, "#stand-name", "b7")
    assert has_element?(view, "#replace-count", "1")
    assert has_element?(view, "#craft-name", "ATR 42")
  end
end

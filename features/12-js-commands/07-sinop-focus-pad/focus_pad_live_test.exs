defmodule PhoenixMultivitaminWeb.SinopFocusPadLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/07-sinop-focus-pad"

  test "focus and focus_first are on the pad buttons", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Elif")
    assert html =~ "focus"
    assert html =~ "focus_first"
    assert html =~ "#slot-input"
    assert html =~ "#pad-fields"
  end
end

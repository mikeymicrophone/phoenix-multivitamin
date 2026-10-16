defmodule PhoenixMultivitaminWeb.FunafutiOnceStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/12-funafuti-once-stream"

  test "the hop count is an assign, not a second stream walk", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#hop-count", "1")
    assert has_element?(view, "#hops", "Nanumea")

    view |> element("#add-nukufetau") |> render_click()
    assert has_element?(view, "#hop-count", "2")
    assert has_element?(view, "#hops", "Nukufetau")
  end
end

defmodule PhoenixMultivitaminWeb.LuderitzStandStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/02-luderitz-stand-stream"

  test "stream_insert appends Kolmanskop", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#stand-diamond", "Diamond")
    refute has_element?(view, "#stand-kolmanskop")

    view |> element("#append-kolmanskop") |> render_click()
    assert has_element?(view, "#stand-kolmanskop", "Kolmanskop")
  end
end

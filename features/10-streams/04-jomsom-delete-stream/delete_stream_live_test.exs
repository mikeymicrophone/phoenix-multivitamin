defmodule PhoenixMultivitaminWeb.JomsomDeleteStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/04-jomsom-delete-stream"

  test "stream_delete removes the finished Mustang leg", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#leg-mustang", "Mustang")
    assert has_element?(view, "#leg-kali", "Kali Gandaki")

    view |> element("#finish-mustang") |> render_click()
    refute has_element?(view, "#leg-mustang")
    assert has_element?(view, "#leg-kali", "Kali Gandaki")
  end
end

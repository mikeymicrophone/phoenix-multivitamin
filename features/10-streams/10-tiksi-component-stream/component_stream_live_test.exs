defmodule PhoenixMultivitaminWeb.TiksiComponentStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/10-tiksi-component-stream"

  test "each hoist row is a LiveComponent", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aytal")
    assert has_element?(view, "#hoist-lena", "Lena mouth")

    view |> element("#add-laptev") |> render_click()
    assert has_element?(view, "#hoist-laptev", "Laptev pack")
  end
end

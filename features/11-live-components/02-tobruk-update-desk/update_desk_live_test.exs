defmodule PhoenixMultivitaminWeb.TobrukUpdateDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/02-tobruk-update-desk"

  test "update/2 receives the later west stand", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-stand", "east")
    assert has_element?(view, "#update-count", "1")

    view |> element("#swing-west") |> render_click()
    assert has_element?(view, "#cell-stand", "west")
    assert has_element?(view, "#update-count", "2")
  end
end

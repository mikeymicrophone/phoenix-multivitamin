defmodule PhoenixMultivitaminWeb.KhorogParentPingLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/04-khorog-parent-ping"

  test "the cell send/2 paints the ridge on the parent", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#ridge-name", "quiet")

    view |> element("#ping-parent") |> render_click()
    assert has_element?(view, "#ridge-name", "Gunt ridge")
  end
end

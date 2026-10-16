defmodule PhoenixMultivitaminWeb.IqaluitMedevacNavigateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @pad "/features/07-liveview-navigation/04-iqaluit-medevac-navigate"
  @hold @pad <> "/hold"

  test "a navigate link opens the hold board as a new LiveView", %{conn: conn} do
    {:ok, view, _html} = live(conn, @pad)
    assert has_element?(view, "#clerk-name", "Aput")
    assert has_element?(view, "#surface-name", "pad")

    {:ok, hold, _html} =
      view
      |> element("#open-hold")
      |> render_click()
      |> follow_redirect(conn, @hold)

    assert has_element?(hold, "#surface-name", "hold")
    assert has_element?(hold, "#craft-name", "Dash 8-300")
  end
end

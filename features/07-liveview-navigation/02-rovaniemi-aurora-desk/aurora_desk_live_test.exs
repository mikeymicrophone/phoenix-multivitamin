defmodule PhoenixMultivitaminWeb.RovaniemiAuroraDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @desk "/features/07-liveview-navigation/02-rovaniemi-aurora-desk"
  @cabin @desk <> "/cabin"

  test "navigate/2 mounts the cabin LiveView and drops desk clicks", %{conn: conn} do
    {:ok, view, _html} = live(conn, @desk)
    assert has_element?(view, "#clerk-name", "Aino")
    assert has_element?(view, "#surface-name", "desk")

    view |> element("#tick-desk") |> render_click()
    assert has_element?(view, "#desk-clicks", "1")

    {:ok, cabin, _html} =
      view
      |> element("#open-cabin")
      |> render_click()
      |> follow_redirect(conn, @cabin)

    assert has_element?(cabin, "#surface-name", "cabin")
    assert has_element?(cabin, "#cabin-clicks", "0")
    assert has_element?(cabin, "#craft-name", "ATR 72")
  end
end

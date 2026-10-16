defmodule PhoenixMultivitaminWeb.YakutskFrostPatchesLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/03-yakutsk-frost-patches"

  test "a patch link swaps the frost stand without remounting", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Sardaana")
    assert has_element?(view, "#stand-name", "north")

    view |> element("#patch-south") |> render_click()
    assert_patch(view, @path <> "?stand=south")
    assert has_element?(view, "#stand-name", "south")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#craft-name", "Sukhoi Superjet 100")
  end
end

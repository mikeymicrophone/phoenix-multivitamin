defmodule PhoenixMultivitaminWeb.LabuanBajoKomodoCellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/11-labuan-bajo-komodo-cell"

  test "the cell asks the parent to patch the Rinca stand", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Wayan")
    assert has_element?(view, "#stand-name", "komodo")
    assert has_element?(view, "#cell-clerk", "Wayan")

    view |> element("#open-rinca") |> render_click()
    assert_patch(view, @path <> "?stand=rinca")
    assert has_element?(view, "#stand-name", "rinca")
    assert has_element?(view, "#mount-count", "1")
    assert has_element?(view, "#craft-name", "Cessna 208")
  end
end

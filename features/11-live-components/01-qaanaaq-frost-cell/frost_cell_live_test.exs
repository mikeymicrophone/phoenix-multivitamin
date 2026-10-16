defmodule PhoenixMultivitaminWeb.QaanaaqFrostCellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/01-qaanaaq-frost-cell"

  test "the frost cell keeps taps under its own id", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Niviaq")
    assert has_element?(view, "#frost-taps", "0")

    view |> element("#tap-frost") |> render_click()
    assert has_element?(view, "#frost-taps", "1")
  end
end

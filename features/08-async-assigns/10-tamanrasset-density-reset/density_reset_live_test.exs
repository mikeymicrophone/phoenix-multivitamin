defmodule PhoenixMultivitaminWeb.TamanrassetDensityResetLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/10-tamanrasset-density-reset"

  test "reset: true clears the first card, then the recomputed card lands", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "Yasmina"
    assert has_element?(view, "#card-value", "DA 4440 ft")

    view |> element("#recompute-card") |> render_click()
    html = render_async(view)
    assert html =~ "DA 4510 ft"
    assert has_element?(view, "#card-value", "DA 4510 ft")
    assert has_element?(view, "#craft-name", "CASA C-295")
  end
end

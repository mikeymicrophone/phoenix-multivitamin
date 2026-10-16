defmodule PhoenixMultivitaminWeb.PetropavlovskCapstoneRackLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/13-petropavlovsk-capstone-rack"

  test "the rack batches two cells and hails the parent", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#site-avacha", "Avacha")
    assert has_element?(view, "#site-bezymianny", "Bezymianny")
    assert has_element?(view, "#batch-avacha", "2")
    assert has_element?(view, "#last-hail", "quiet")

    view |> element("#hail-avacha") |> render_click()
    assert has_element?(view, "#last-hail", "Avacha")
  end
end

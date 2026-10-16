defmodule PhoenixMultivitaminWeb.KuujjuaqDisabledSubmitLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/11-kuujjuaq-disabled-submit"

  test "the stamp stays disabled until the ice card is valid", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Elisapie")
    assert has_element?(view, "#card-valid", "invalid")
    assert has_element?(view, "#stamp-ice[disabled]")

    view
    |> form("#ice-card-form", ice_card: %{ice_mm: "12"})
    |> render_change()

    assert has_element?(view, "#card-valid", "valid")
    refute has_element?(view, "#stamp-ice[disabled]")
  end
end

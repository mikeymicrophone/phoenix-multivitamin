defmodule PhoenixMultivitaminWeb.MaunDeltaWeightLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/03-maun-delta-weight"

  test "submit persists only a valid safari weight", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Kagiso")

    view
    |> form("#weight-card-form", weight_card: %{souls: "12"})
    |> render_submit()

    refute has_element?(view, "#posted-souls")
    assert has_element?(view, "#weight-card-form", "must be less than or equal to 8")

    view
    |> form("#weight-card-form", weight_card: %{souls: "5"})
    |> render_submit()

    assert has_element?(view, "#posted-souls", "5")
  end
end

defmodule PhoenixMultivitaminWeb.MagadanCapstoneCardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitamin.MagadanFuelCard
  alias PhoenixMultivitamin.Repo

  @path "/features/09-forms-and-changesets/13-magadan-capstone-card"

  test "live validation and a nested write land in the Repo", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Stepan")
    assert has_element?(view, "[name='fuel_card[payload][cargo_kg]']")

    view
    |> form("#fuel-card-form", fuel_card: %{litres: "0"})
    |> render_change()

    assert has_element?(view, "#fuel-card-form", "must be greater than 0")

    view
    |> form("#fuel-card-form", %{
      fuel_card: %{
        litres: "42000",
        payload: %{cargo_kg: "18000", souls: "7"}
      }
    })
    |> render_submit()

    assert has_element?(view, "#written-litres", "42000")
    assert Repo.get_by(MagadanFuelCard, litres: 42_000).clerk == "Stepan"
  end
end

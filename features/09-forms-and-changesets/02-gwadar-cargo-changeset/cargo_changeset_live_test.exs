defmodule PhoenixMultivitaminWeb.GwadarCargoChangesetLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/02-gwadar-cargo-changeset"

  test "phx-change rejects a pallet over eight tonnes", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Parveen")
    assert has_element?(view, "#craft-name", "Antonov An-12")

    view
    |> form("#cargo-card-form", cargo_card: %{pallet_kg: "9000"})
    |> render_change()

    assert has_element?(view, "#cargo-card-form", "must be less than or equal to 8000")
  end
end

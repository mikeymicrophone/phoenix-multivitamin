defmodule PhoenixMultivitaminWeb.TannaAshValidateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/10-tanna-ash-validate"

  test "change is validate and submit is insert", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Leipakoa")
    assert has_element?(view, "#form-action", "none")

    view
    |> form("#ash-card-form", ash_card: %{ash_ft: "12000"})
    |> render_change()

    assert has_element?(view, "#form-action", "validate")
    refute has_element?(view, "#posted-ash")

    view
    |> form("#ash-card-form", ash_card: %{ash_ft: "12000"})
    |> render_submit()

    assert has_element?(view, "#form-action", "insert")
    assert has_element?(view, "#posted-ash", "12000")
  end
end

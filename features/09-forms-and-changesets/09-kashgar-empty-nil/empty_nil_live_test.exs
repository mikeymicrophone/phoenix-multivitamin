defmodule PhoenixMultivitaminWeb.KashgarEmptyNilLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/09-kashgar-empty-nil"

  test "an empty endurance box casts to nil", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Dilbar")
    assert has_element?(view, "#filed-endurance", "not filed")

    view
    |> form("#endurance-card-form", endurance_card: %{endurance_min: ""})
    |> render_submit()

    assert has_element?(view, "#filed-endurance", "nil")
  end
end

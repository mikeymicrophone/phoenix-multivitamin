defmodule PhoenixMultivitaminWeb.AitutakiResetFormLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/12-aitutaki-reset-form"

  test "a successful stamp resets the passenger box", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Moana")

    html =
      view
      |> form("#lagoon-card-form", lagoon_card: %{passengers: "9"})
      |> render_submit()

    assert has_element?(view, "#last-passengers", "9")
    refute html =~ ~s(value="9")
  end
end

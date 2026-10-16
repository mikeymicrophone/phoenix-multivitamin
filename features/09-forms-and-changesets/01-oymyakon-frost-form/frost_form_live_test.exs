defmodule PhoenixMultivitaminWeb.OymyakonFrostFormLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/01-oymyakon-frost-form"

  test "to_form wraps the frost-delay changeset", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Oymyakon frost form"
    assert has_element?(view, "#clerk-name", "Tuyara")
    assert has_element?(view, "#craft-name", "Antonov An-2")
    assert has_element?(view, "#frost-slot-form")
    assert has_element?(view, "#frost_slot_delay_min")
  end
end

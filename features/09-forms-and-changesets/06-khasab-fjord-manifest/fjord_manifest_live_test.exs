defmodule PhoenixMultivitaminWeb.KhasabFjordManifestLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/06-khasab-fjord-manifest"

  test "the manifest uses select, checkbox, and textarea", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Thuraya")
    assert has_element?(view, "#craft-name", "Let L-410")
    assert has_element?(view, "select#fjord_manifest_fjord")
    assert has_element?(view, "input#fjord_manifest_night_vision")
    assert has_element?(view, "textarea#fjord_manifest_remarks")
  end
end

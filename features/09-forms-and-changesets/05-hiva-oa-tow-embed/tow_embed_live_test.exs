defmodule PhoenixMultivitaminWeb.HivaOaTowEmbedLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/05-hiva-oa-tow-embed"

  test "the nested tow embed is on the form", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Hiva Oa tow embed"
    assert has_element?(view, "#clerk-name", "Heiata")
    assert has_element?(view, "#craft-name", "Cessna 185 Skywagon")
    assert has_element?(view, "#tow-card-form")
    assert has_element?(view, "[name='tow_card[tow][pilot]']")
    assert has_element?(view, "[name='tow_card[tow][rope_m]']")
  end
end

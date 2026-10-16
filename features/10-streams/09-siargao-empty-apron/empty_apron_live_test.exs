defmodule PhoenixMultivitaminWeb.SiargaoEmptyApronLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/09-siargao-empty-apron"

  test "the empty apron hides once Cloud 9 parks", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#empty-apron", "Apron is empty.")
    refute has_element?(view, "#stands", "Cloud 9")

    view |> element("#park-cloud") |> render_click()
    assert has_element?(view, "#stands", "Cloud 9")
  end
end

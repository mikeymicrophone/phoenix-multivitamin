defmodule PhoenixMultivitaminWeb.CoyhaiqueBriefCellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/11-live-components/05-coyhaique-brief-cell"

  test "the parent message reaches the cell through update/2", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cell-brief", "pending")

    view |> element("#fetch-brief") |> render_click()
    assert has_element?(view, "#cell-brief", "wave over the Simpson")
  end
end

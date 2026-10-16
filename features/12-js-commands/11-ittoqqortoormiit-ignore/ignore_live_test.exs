defmodule PhoenixMultivitaminWeb.IttoqqortoormiitIgnoreLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/11-ittoqqortoormiit-ignore"

  test "ignore_attributes is mounted on the icing dialog", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aputsiaq")
    assert html =~ "ignore_attrs"
    assert html =~ "open"
    assert has_element?(view, "#icing-dialog")

    view |> element("#tick-sund") |> render_click()
    assert has_element?(view, "#sund-ticks", "1")
    assert has_element?(view, "#icing-dialog")
  end
end

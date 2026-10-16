defmodule PhoenixMultivitaminWeb.PragueGettextFlashLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/10-prague-gettext-flash"

  test "the layout flash group already ships gettext reconnect copy", %{conn: conn} do
    {:ok, _view, html} = live(conn, @path)
    assert html =~ "We can't find the internet"
    assert html =~ "Attempting to reconnect"
    assert html =~ "Jana"
  end

  test "hold short puts a gettext flash through the layout", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_click(element(view, "#hold-short"))
    assert html =~ "Hold short of the threshold"
    assert has_element?(view, "#flash-info")

    assert Gettext.gettext(PhoenixMultivitaminWeb.Gettext, "Hold short of the threshold") ==
             "Hold short of the threshold"
  end
end

defmodule PhoenixMultivitaminWeb.PuertoNatalesWindFetchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/01-puerto-natales-wind-fetch"

  test "assign_async does not start on the dead render", %{conn: conn} do
    html = html_response(get(conn, @path), 200)
    assert html =~ "Puerto Natales wind fetch"
    assert html =~ "Esperanza"
    assert html =~ "Wind still out on the steppe."
    refute html =~ "32022G34KT"
  end

  test "the connected mount fills the wind after render_async", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Esperanza"
    html = render_async(view)
    assert html =~ "32022G34KT"
    assert has_element?(view, "#wind-value", "32022G34KT")
    assert has_element?(view, "#craft-name", "Pilatus PC-6")
    refute has_element?(view, "#wind-loading")
  end
end

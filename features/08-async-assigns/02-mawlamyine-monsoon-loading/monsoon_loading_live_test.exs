defmodule PhoenixMultivitaminWeb.MawlamyineMonsoonLoadingLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/02-mawlamyine-monsoon-loading"

  test "the loading slot paints on the dead render", %{conn: conn} do
    html = html_response(get(conn, @path), 200)
    assert html =~ "Mawlamyine monsoon loading"
    assert html =~ "Su"
    assert html =~ "Sounding still out over the Salween."
    refute html =~ "broken 012, rain"
  end

  test "render_async fills the sounding and drops the loading slot", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "broken 012, rain"
    assert has_element?(view, "#sounding-value", "broken 012, rain")
    refute has_element?(view, "#sounding-loading")
    assert has_element?(view, "#craft-name", "Fokker 70")
  end
end

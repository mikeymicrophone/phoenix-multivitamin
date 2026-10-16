defmodule PhoenixMultivitaminWeb.UpernavikTripleFetchLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/07-upernavik-triple-fetch"

  test "one async function fills wind, temp, and QNH together", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ "Ivalu"
    html = render_async(view)
    assert html =~ "04018KT"
    assert has_element?(view, "#wind-value", "04018KT")
    assert has_element?(view, "#temp-value", "-22")
    assert has_element?(view, "#qnh-value", "998")
    refute has_element?(view, "#triple-loading")
    assert has_element?(view, "#craft-name", "Dash 8-200")
  end
end

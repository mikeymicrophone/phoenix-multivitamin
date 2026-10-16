defmodule PhoenixMultivitaminWeb.GuadalajaraFuelFlashLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/02-guadalajara-fuel-flash"

  test "posting the bowser paints an info flash through the layout", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_click(element(view, "#post-bowser"))
    assert html =~ "Luz posted Jet A-1 on stand 12"
    assert has_element?(view, "#flash-info")
    refute html =~ "Jet A-1 spill"
  end

  test "a spill paints an error flash through the same flash_group", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_click(element(view, "#spill-bowser"))
    assert html =~ "Jet A-1 spill on the hydrant pit"
    assert has_element?(view, "#flash-error")
  end
end

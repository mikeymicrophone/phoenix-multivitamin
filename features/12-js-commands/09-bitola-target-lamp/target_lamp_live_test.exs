defmodule PhoenixMultivitaminWeb.BitolaTargetLampLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/09-bitola-target-lamp"

  test "to: points at a different lamp than the button", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#light-other")
    assert has_element?(view, "#pelister-lamp")
    assert html =~ "#pelister-lamp"
    refute html =~ ~s(to: "#light-other")
  end
end

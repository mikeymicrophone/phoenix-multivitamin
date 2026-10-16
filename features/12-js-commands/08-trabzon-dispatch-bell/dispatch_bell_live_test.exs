defmodule PhoenixMultivitaminWeb.TrabzonDispatchBellLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/08-trabzon-dispatch-bell"

  test "dispatch names the fuel-chime event", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aylin")
    assert html =~ "dispatch"
    assert html =~ "fuel-chime"
    assert html =~ "#chime-bell"
  end
end

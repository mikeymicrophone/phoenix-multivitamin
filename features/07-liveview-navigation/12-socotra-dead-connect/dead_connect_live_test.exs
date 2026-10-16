defmodule PhoenixMultivitaminWeb.SocotraDeadConnectLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/07-liveview-navigation/12-socotra-dead-connect"

  test "the destination dead-renders, then live/2 connects", %{conn: conn} do
    html = html_response(get(conn, @path), 200)
    assert html =~ "Socotra dead connect"
    assert html =~ "Dead render of the Socotra threshold."
    assert html =~ "Nadir"
    refute html =~ "Socket connected on the Socotra threshold."

    {:ok, view, connected} = live(conn, @path)
    assert connected =~ "Socket connected on the Socotra threshold."
    assert has_element?(view, "#clerk-name", "Nadir")
    assert has_element?(view, "#craft-name", "Antonov An-26")
    refute has_element?(view, "#mount-banner", "Dead render of the Socotra threshold.")
  end
end

defmodule PhoenixMultivitaminWeb.ResoluteDepartureStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/01-resolute-departure-stream"

  test "stream/4 paints the Polaris departure", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Aaluk")
    assert has_element?(view, "#craft-name", "DHC-5 Buffalo")
    assert has_element?(view, "#stand-polaris", "Polaris")
    assert has_element?(view, "#wind-polaris", "34028KT")
  end
end

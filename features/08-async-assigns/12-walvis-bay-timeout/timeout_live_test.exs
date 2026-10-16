defmodule PhoenixMultivitaminWeb.WalvisBayTimeoutLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/12-walvis-bay-timeout"

  test "a timed-out sounding fails as {:error, :sounding_timeout}", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "Ndapewa"
    assert html =~ "sounding_timeout"
    assert has_element?(view, "#sounding-failed", "{:error, :sounding_timeout}")
    assert has_element?(view, "#craft-name", "CRJ700")
    refute has_element?(view, "#sounding-loading")
  end
end

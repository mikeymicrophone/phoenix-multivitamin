defmodule PhoenixMultivitaminWeb.VanIcingRetryLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/04-van-icing-retry"

  test "the failed reason paints, then retry fills icing", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "Berfin"
    assert html =~ "icing_probe_dark"
    assert has_element?(view, "#icing-failed", "icing_probe_dark")
    refute has_element?(view, "#icing-value")

    view |> element("#retry-probe") |> render_click()
    html = render_async(view)
    assert html =~ "trace ice at 8000"
    assert has_element?(view, "#icing-value", "trace ice at 8000")
    refute has_element?(view, "#icing-failed")
    assert has_element?(view, "#craft-name", "Antonov An-74")
  end
end

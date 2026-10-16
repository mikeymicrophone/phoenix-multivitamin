defmodule PhoenixMultivitaminWeb.BalmacedaCapstoneDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/08-async-assigns/13-balmaceda-capstone-desk"

  test "wind lands, icing fails, retry fills icing on the same desk", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "Pascual"
    assert has_element?(view, "#wind-value", "27028G40KT")
    assert has_element?(view, "#icing-failed", "icing_probe_dark")
    refute has_element?(view, "#icing-value")

    view |> element("#retry-icing") |> render_click()
    html = render_async(view)
    assert html =~ "moderate rime"
    assert has_element?(view, "#icing-value", "moderate rime")
    assert has_element?(view, "#wind-value", "27028G40KT")
    assert has_element?(view, "#craft-name", "BAe 146")
  end
end

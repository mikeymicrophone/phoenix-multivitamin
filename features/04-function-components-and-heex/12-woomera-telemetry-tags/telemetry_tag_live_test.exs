defmodule PhoenixMultivitaminWeb.WoomeraTelemetryTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/12-woomera-telemetry-tags"

  test "a range-stamp note interpolates escaped, and a safe glyph does not", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Woomera range"
    assert html =~ "Darcy"
    assert html =~ "&lt;range-stamp lot=&quot;WO-24-8&quot;&gt;"
    refute html =~ ~r/<range-stamp[^>]*>/
    assert has_element?(view, "#range-glyph", "WO")
    assert has_element?(view, "#range-stamp-code", "WO-4418")
    assert html =~ ~s(data-note="&lt;range-stamp lot=&quot;WO-24-8&quot;&gt;)
  end

  test "raw/1 injects the note as markup", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#print-raw-note") |> render_click()
    note = view |> element("#brant-tag-note") |> render()
    assert note =~ ~r/<range-stamp[^>]*>/
    refute note =~ "&lt;range-stamp"

    view |> element("#print-escaped-note") |> render_click()
    html = render(view)
    assert html =~ "&lt;range-stamp"
  end
end

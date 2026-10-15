defmodule PhoenixMultivitaminWeb.HokoRiverSmoltTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/12-hoko-river-smolt-tags"

  test "a fin-clip note interpolates escaped, and a safe glyph does not", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Hoko Falls Hatchery"
    assert html =~ "Wren"
    assert html =~ "&lt;adipose-clip lot=&quot;HK-24-8&quot;&gt;"
    refute html =~ ~r/<adipose-clip[^>]*>/
    assert has_element?(view, "#hatchery-glyph", "HK")
    assert html =~ ~s(data-note="&lt;adipose-clip lot=&quot;HK-24-8&quot;&gt;)
  end

  test "raw/1 injects the note as markup", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#print-raw-note") |> render_click()
    note = view |> element("#coho-tag-note") |> render()
    assert note =~ ~r/<adipose-clip[^>]*>/
    refute note =~ "&lt;adipose-clip"

    view |> element("#print-escaped-note") |> render_click()
    html = render(view)
    assert html =~ "&lt;adipose-clip"
  end
end

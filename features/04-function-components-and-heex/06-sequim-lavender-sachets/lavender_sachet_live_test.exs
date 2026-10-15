defmodule PhoenixMultivitaminWeb.SequimLavenderSachetsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/06-sequim-lavender-sachets"

  test "class lists drop nil and false and flatten nested lists", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Purple Haze Lavender"
    assert html =~ "Mireille"
    grosso = view |> element("#grosso-sachet") |> render()
    assert grosso =~ "sachet"
    assert grosso =~ "lavender"
    refute grosso =~ "cured"
    refute grosso =~ "super-blue"
    refute grosso =~ "false"
    refute grosso =~ "nil"

    hidcote = view |> element("#hidcote-sachet") |> render()
    assert hidcote =~ "cured"
    assert hidcote =~ "super-blue"
  end

  test "dynamic attributes spread onto the sachet", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ ~s(data-field="west-five")
    assert html =~ ~s(aria-label="Grosso sachet from west five")
    assert html =~ ~s(data-still="copper-20")
    assert has_element?(view, "#hidcote-sachet[tabindex='0']")

    view |> element("#hide-aria") |> render_click()
    html = render(view)
    refute html =~ ~s(aria-label="Grosso sachet from west five")
    assert html =~ ~s(data-field="west-five")
  end

  test "curing Grosso adds the cured class, and class={false} still renders class", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#cure-grosso") |> render_click()
    assert view |> element("#grosso-sachet") |> render() =~ "cured"
    assert has_element?(view, "#grosso-sachet", "cured on the rack")

    blank = view |> element("#blank-class-sachet") |> render()
    assert blank =~ ~s(class="")
  end
end

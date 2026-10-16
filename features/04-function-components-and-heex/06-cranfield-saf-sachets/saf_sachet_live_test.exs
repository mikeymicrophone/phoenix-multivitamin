defmodule PhoenixMultivitaminWeb.CranfieldSafSachetsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/06-cranfield-saf-sachets"

  test "class lists drop nil and false and flatten nested lists", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Cranfield SAF lab"
    assert html =~ "Iona"
    hefa = view |> element("#hefa-sachet") |> render()
    assert hefa =~ "sachet"
    assert hefa =~ "saf"
    refute hefa =~ "certified"
    refute hefa =~ "drop-in"
    refute hefa =~ "false"
    refute hefa =~ "nil"

    ft = view |> element("#ft-sachet") |> render()
    assert ft =~ "certified"
    assert ft =~ "drop-in"
  end

  test "dynamic attributes spread onto the sachet", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ ~s(data-field="lab-two")
    assert html =~ ~s(aria-label="HEFA sachet from lab two")
    assert html =~ ~s(data-reactor="ft-20")
    assert has_element?(view, "#ft-sachet[tabindex='0']")

    view |> element("#hide-aria") |> render_click()
    html = render(view)
    refute html =~ ~s(aria-label="HEFA sachet from lab two")
    assert html =~ ~s(data-field="lab-two")
  end

  test "certifying HEFA adds the certified class, and class={false} still renders class", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#certify-hefa") |> render_click()
    assert view |> element("#hefa-sachet") |> render() =~ "certified"
    assert has_element?(view, "#hefa-sachet", "certified drop-in")

    blank = view |> element("#blank-class-sachet") |> render()
    assert blank =~ ~s(class="")
  end
end

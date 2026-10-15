defmodule PhoenixMultivitaminWeb.ChimacumCiderLabelsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/03-chimacum-cider-labels"

  test "the Kingston Black template prints with attr defaults", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Finnriver Cidery · Chimacum"
    assert html =~ "Soren"
    assert has_element?(view, "#kingston-black-label", "Press run CV-24-19")
    assert has_element?(view, "#kingston-black-bushels", "12")
    assert has_element?(view, "#kingston-black-sweetness", "dry")
    refute has_element?(view, "#yarlington-mill-label")
  end

  test "switching the sheet renders the Yarlington Mill embedded template", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#print-yarlington") |> render_click()
    assert has_element?(view, "#yarlington-mill-label", "Press run CV-24-22")
    assert has_element?(view, "#yarlington-mill-bushels", "8")
    assert has_element?(view, "#yarlington-mill-blend", "with Dabinett")
    refute has_element?(view, "#kingston-black-label")

    view |> element("#print-kingston") |> render_click()
    assert has_element?(view, "#kingston-black-label")
  end
end

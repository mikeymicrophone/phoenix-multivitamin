defmodule PhoenixMultivitaminWeb.FiltonConcordeLabelsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/03-filton-concorde-labels"

  test "the G-BOAC template prints with attr defaults", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Aerospace Bristol · Filton"
    assert html =~ "Isolde"
    assert has_element?(view, "#g-boac-label", "Plate run CV-24-19")
    assert has_element?(view, "#g-boac-hours", "12")
    assert has_element?(view, "#g-boac-stance", "grounded")
    refute has_element?(view, "#f-btsd-label")
  end

  test "switching the sheet renders the F-BTSD embedded template", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#print-f-btsd") |> render_click()
    assert has_element?(view, "#f-btsd-label", "Plate run CV-24-22")
    assert has_element?(view, "#f-btsd-hours", "8")
    assert has_element?(view, "#f-btsd-caption", "with British markings")
    refute has_element?(view, "#g-boac-label")

    view |> element("#print-g-boac") |> render_click()
    assert has_element?(view, "#g-boac-label")
  end
end

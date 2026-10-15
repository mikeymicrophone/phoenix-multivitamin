defmodule PhoenixMultivitaminWeb.IrondaleFoundryHeatSlipsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/08-irondale-foundry-heat-slips"

  test "a heat slip renders pour rows which render alloy chips", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Irondale Furnace"
    assert html =~ "Bessa"
    assert has_element?(view, "#heat-14-note", "charcoal pig")
    assert has_element?(view, "#heat-14-try-pot", "420 lb")
    assert has_element?(view, "#heat-14-try-pot-alloy", "No. 2 foundry")
    assert has_element?(view, "#heat-14-sash-weight-alloy", "silvery pig")
    refute has_element?(view, "#heat-14-try-pot-alloy", "east stack")
  end

  test "adding a pour composes a new row and chip without rewriting the slip", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#add-keel-pour") |> render_click()
    assert has_element?(view, "#heat-14-keel-block", "640 lb")
    assert has_element?(view, "#heat-14-keel-block-alloy", "low-phos")
    assert has_element?(view, "#heat-14-try-pot-alloy", "No. 2 foundry")
  end
end

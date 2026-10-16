defmodule PhoenixMultivitaminWeb.DerbyTrentHeatSlipsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/08-derby-trent-heat-slips"

  test "a heat slip renders stage rows which render alloy chips", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Rolls-Royce · Derby"
    assert html =~ "Gareth"
    assert has_element?(view, "#heat-14-note", "Trent remelt")
    assert has_element?(view, "#heat-14-ip-turbine", "420 lb")
    assert has_element?(view, "#heat-14-ip-turbine-alloy", "IP billet")
    assert has_element?(view, "#heat-14-lp-compressor-alloy", "LP billet")
    refute has_element?(view, "#heat-14-ip-turbine-alloy", "XWB cell three")
  end

  test "adding a stage composes a new row and chip without rewriting the slip", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#add-fan-stage") |> render_click()
    assert has_element?(view, "#heat-14-fan-case", "640 lb")
    assert has_element?(view, "#heat-14-fan-case-alloy", "fan billet")
    assert has_element?(view, "#heat-14-ip-turbine-alloy", "IP billet")
  end
end

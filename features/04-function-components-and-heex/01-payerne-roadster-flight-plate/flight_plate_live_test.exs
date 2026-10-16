defmodule PhoenixMultivitaminWeb.PayerneRoadsterFlightPlateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.PayerneRoadsterFlightPlateLive

  @path "/features/04-function-components-and-heex/01-payerne-roadster-flight-plate"

  test "the press prints required attrs and fills defaults", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Payerne"
    assert html =~ "Nuri"
    assert has_element?(view, "#showroom-plate [data-field=hangar]", "PAY-A-12")
    assert has_element?(view, "#showroom-plate [data-field=puffs]", "3 puffs")
    assert has_element?(view, "#showroom-plate [data-field=kind]", "showroom")
    assert has_element?(view, "#showroom-plate [data-field=thrusters]", "thrusters live")
    assert has_element?(view, "#prototype-plate [data-field=puffs]", "4 puffs")
    assert has_element?(view, "#chase-plate [data-field=thrusters]", "thrusters idle")
    assert has_element?(view, "#chase-plate [data-field=kind]", "parade")
  end

  test "stamping showroom as parade updates only the values: attr", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#stamp-parade-showroom") |> render_click()
    assert has_element?(view, "#showroom-plate [data-field=kind]", "parade")
    assert has_element?(view, "#prototype-plate [data-field=kind]", "prototype")

    view |> element("#stamp-showroom-showroom") |> render_click()
    assert has_element?(view, "#showroom-plate [data-field=kind]", "showroom")
  end

  test "passing nil for puff_count does not restore the default of 3", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#weigh-prototype-empty") |> render_click()
    assert has_element?(view, "#prototype-plate [data-field=puffs]", "whistle silent")
    refute has_element?(view, "#prototype-plate [data-field=puffs]", "3 puffs")

    view |> element("#weigh-prototype-default") |> render_click()
    assert has_element?(view, "#prototype-plate [data-field=puffs]", "4 puffs")
  end

  test "a direct call still receives attr defaults from the generated wrapper" do
    html =
      render_component(&PayerneRoadsterFlightPlateLive.flight_plate/1, %{
        id: "direct-plate",
        livery: "Midnight chrome",
        hangar: "PAY-D-9"
      })

    assert html =~ "Midnight chrome"
    assert html =~ "3 puffs"
    assert html =~ "showroom"
    assert html =~ "thrusters live"
  end
end

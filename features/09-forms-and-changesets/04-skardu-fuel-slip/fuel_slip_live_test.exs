defmodule PhoenixMultivitaminWeb.SkarduFuelSlipLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/04-skardu-fuel-slip"

  test "a fat slip paints the litres error beside the input", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Nazeer")
    assert has_element?(view, "#craft-name", "Pilatus PC-24")

    view
    |> form("#fuel-slip-form", fuel_slip: %{litres: "4000"})
    |> render_change()

    assert has_element?(view, "#fuel-slip-form", "must be less than or equal to 2700")
  end
end

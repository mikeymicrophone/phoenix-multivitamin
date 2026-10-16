defmodule PhoenixMultivitaminWeb.IstanbulCargoModalLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/07-istanbul-cargo-modal"

  test "the desk ships a core input, button, and hidden modal", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#kg-field")
    assert has_element?(view, "#open-hold")
    assert has_element?(view, "#hold-modal")
    assert html =~ "hidden"
    assert html =~ "Deniz"
    assert html =~ "Boeing 747-400F"
    assert html =~ "w-full input"
  end

  test "confirming the modal puts a flash through the layout", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_change(element(view, "#kg-form"), %{"kg" => "14000"})
    render_click(element(view, "#open-hold"))
    html = render_click(element(view, "#confirm-hold button"))
    assert html =~ "Deniz held the 747-400F at 14000 kg"
    assert has_element?(view, "#flash-info")
  end
end

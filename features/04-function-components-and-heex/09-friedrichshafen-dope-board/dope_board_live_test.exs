defmodule PhoenixMultivitaminWeb.FriedrichshafenDopeBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/09-friedrichshafen-dope-board"

  test "Map.put freezes the firing pass while assign/3 updates it", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Zeppelin NT loft"
    assert html =~ "Klara"
    map_put_pass = view |> element("#map-put-pass-envelope") |> render()
    assign_pass = view |> element("#assign-pass-envelope") |> render()
    quiet_pass = view |> element("#quiet-pass") |> render()
    assert map_put_pass =~ "pass-"
    assert assign_pass =~ "pass-"

    view |> element("#raise-loft") |> render_click()
    assert has_element?(view, "#loft-temp", "1875")
    assert has_element?(view, "#map-put-loft-envelope", "1875")
    assert has_element?(view, "#assign-loft-envelope", "1875")
    assert view |> element("#map-put-pass-envelope") |> render() == map_put_pass
    refute view |> element("#assign-pass-envelope") |> render() == assign_pass
    assert view |> element("#quiet-pass") |> render() == quiet_pass
  end

  test "dipping tint updates every chip that was passed tint", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    quiet_pass = view |> element("#quiet-pass") |> render()
    view |> element("#dip-aluminium") |> render_click()
    assert has_element?(view, "#map-put-tint-envelope", "aluminium pigment")
    assert has_element?(view, "#assign-tint-envelope", "aluminium pigment")
    assert has_element?(view, "#quiet-tint", "aluminium pigment")
    refute view |> element("#quiet-pass") |> render() == quiet_pass
  end
end

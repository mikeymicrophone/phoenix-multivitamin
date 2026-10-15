defmodule PhoenixMultivitaminWeb.DiscoveryBayTileBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/09-discovery-bay-tile-board"

  test "Map.put freezes the firing pass while assign/3 updates it", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Discovery Bay Encaustic"
    assert html =~ "Ione"
    map_put_pass = view |> element("#map-put-pass-encaustic") |> render()
    assign_pass = view |> element("#assign-pass-encaustic") |> render()
    quiet_pass = view |> element("#quiet-pass") |> render()
    assert map_put_pass =~ "pass-"
    assert assign_pass =~ "pass-"

    view |> element("#raise-kiln") |> render_click()
    assert has_element?(view, "#kiln-temp", "1875")
    assert has_element?(view, "#map-put-kiln-encaustic", "1875")
    assert has_element?(view, "#assign-kiln-encaustic", "1875")
    assert view |> element("#map-put-pass-encaustic") |> render() == map_put_pass
    refute view |> element("#assign-pass-encaustic") |> render() == assign_pass
    assert view |> element("#quiet-pass") |> render() == quiet_pass
  end

  test "dipping glaze updates every chip that was passed glaze", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    quiet_pass = view |> element("#quiet-pass") |> render()
    view |> element("#dip-copper") |> render_click()
    assert has_element?(view, "#map-put-glaze-encaustic", "copper rutile")
    assert has_element?(view, "#assign-glaze-encaustic", "copper rutile")
    assert has_element?(view, "#quiet-glaze", "copper rutile")
    refute view |> element("#quiet-pass") |> render() == quiet_pass
  end
end

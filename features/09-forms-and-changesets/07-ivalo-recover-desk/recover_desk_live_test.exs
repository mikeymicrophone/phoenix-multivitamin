defmodule PhoenixMultivitaminWeb.IvaloRecoverDeskLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/09-forms-and-changesets/07-ivalo-recover-desk"

  test "phx-auto-recover refills the deice card", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Sisko")
    assert has_element?(view, "#recover-state", "fresh")

    render_hook(view, "recover_deice", %{
      "deice_card" => %{
        "clerk" => "Sisko",
        "craft" => "Fokker 50",
        "fluid" => "Type IV",
        "tank_c" => "-18"
      }
    })

    assert has_element?(view, "#recover-state", "recovered")
    assert has_element?(view, "#deice_card_fluid")
    html = render(view)
    assert html =~ "Type IV"
  end
end

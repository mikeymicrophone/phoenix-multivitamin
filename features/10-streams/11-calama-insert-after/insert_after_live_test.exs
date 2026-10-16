defmodule PhoenixMultivitaminWeb.CalamaInsertAfterLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/11-calama-insert-after"

  test "Calama mid lands after Chuquicamata north", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Rocío")

    html = view |> element("#insert-mid") |> render_click()
    assert html =~ ~r/Chuquicamata north.*Calama mid.*Loa south/s
  end
end

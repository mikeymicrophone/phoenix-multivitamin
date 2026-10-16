defmodule PhoenixMultivitaminWeb.NadiStreamContainerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/05-nadi-stream-container"

  test "the stream container keeps Nadi west and accepts Momi", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert html =~ ~s(id="slots")
    assert html =~ ~s(phx-update="stream")
    assert has_element?(view, "#clerk-name", "Litia")

    view |> element("#add-momi") |> render_click()
    assert has_element?(view, "#slots", "Momi")
    assert has_element?(view, "#slots", "Nadi west")
  end
end

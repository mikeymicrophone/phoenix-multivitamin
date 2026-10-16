defmodule PhoenixMultivitaminWeb.BatumiFrontStreamLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/10-streams/03-batumi-front-stream"

  test "stream_insert at 0 puts Caucasus first", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Nino")

    html = view |> element("#prepend-caucasus") |> render_click()
    assert html =~ ~r/Caucasus wave.*Black Sea swell/s
  end
end

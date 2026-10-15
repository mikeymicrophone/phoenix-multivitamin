defmodule PhoenixMultivitaminWeb.DestructionIslandReliefBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/07-destruction-island-relief-board"

  test "the markup keeps the debounce attributes for the browser", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Destruction Island Light"
    assert has_element?(view, "#operator-name", "Tove")
    assert html =~ ~s(phx-debounce="500")
    assert html =~ ~s(phx-debounce="blur")
  end

  test "render_change posts radio copy immediately despite phx-debounce=500", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#radio-copy-form")
    |> render_change(%{"relief" => %{"copy" => "CG 47318 departing La Push with stores"}})

    assert has_element?(view, "#last-posted-from", "radio_copy")
    assert has_element?(view, "#radio-copy", "CG 47318 departing La Push")
    assert has_element?(view, "#board-lines", "Radio: CG 47318 departing La Push with stores")
  end

  test "render_change posts a landing note immediately despite phx-debounce=blur", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#landing-form")
    |> render_change(%{"relief" => %{"landing" => "Swell too high on the west face"}})

    assert has_element?(view, "#last-posted-from", "landing")
    assert has_element?(view, "#landing-note", "Swell too high on the west face")
    assert has_element?(view, "#board-lines", "Landing: Swell too high on the west face")
  end
end

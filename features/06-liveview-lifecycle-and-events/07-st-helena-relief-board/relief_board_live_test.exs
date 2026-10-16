defmodule PhoenixMultivitaminWeb.StHelenaReliefBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/07-st-helena-relief-board"

  test "the markup keeps the debounce attributes for the browser", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "St Helena Airport"
    assert has_element?(view, "#clerk-name", "Percy")
    assert html =~ ~s(phx-debounce="500")
    assert html =~ ~s(phx-debounce="blur")
  end

  test "render_change posts radio copy immediately despite phx-debounce=500", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#radio-copy-form")
    |> render_change(%{"relief" => %{"copy" => "SAH 330 departing Johannesburg with stores"}})

    assert has_element?(view, "#last-posted-from", "radio_copy")
    assert has_element?(view, "#radio-copy", "SAH 330 departing Johannesburg")
    assert has_element?(view, "#board-lines", "Radio: SAH 330 departing Johannesburg with stores")
  end

  test "render_change posts a landing note immediately despite phx-debounce=blur", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#landing-form")
    |> render_change(%{"relief" => %{"landing" => "Crosswind too high on 20"}})

    assert has_element?(view, "#last-posted-from", "landing")
    assert has_element?(view, "#landing-note", "Crosswind too high on 20")
    assert has_element?(view, "#board-lines", "Landing: Crosswind too high on 20")
  end
end

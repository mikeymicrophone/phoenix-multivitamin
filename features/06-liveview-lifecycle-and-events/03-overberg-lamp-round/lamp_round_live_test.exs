defmodule PhoenixMultivitaminWeb.OverbergLampRoundLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/03-overberg-lamp-round"

  test "the disconnected mount renders an uninspected round sheet", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Overberg Test Range"
    assert html =~ "Piet"
    assert html =~ "uninspected"
    assert html =~ "No lamp touched this round."
  end

  test "phx-change records the field named in _target", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "runway_papi"],
      "round" => %{"runway_papi" => "trimmed"}
    })

    assert has_element?(view, "#last-target", "runway_papi")
    assert has_element?(view, "#papi-state", "trimmed")
    assert has_element?(view, "#round-lines", "Runway PAPI set to trimmed")
    refute has_element?(view, "#empty-round")
  end

  test "later changes keep earlier lamps and retarget the sheet", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "runway_papi"],
      "round" => %{"runway_papi" => "lit"}
    })

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "threshold_bar"],
      "round" => %{"threshold_bar" => "up-to-pressure"}
    })

    assert has_element?(view, "#papi-state", "lit")
    assert has_element?(view, "#threshold-state", "up-to-pressure")
    assert has_element?(view, "#last-target", "threshold_bar")
    assert has_element?(view, "#round-lines", "Threshold bar set to up-to-pressure")
  end
end

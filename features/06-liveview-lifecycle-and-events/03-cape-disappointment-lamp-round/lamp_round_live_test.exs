defmodule PhoenixMultivitaminWeb.CapeDisappointmentLampRoundLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/03-cape-disappointment-lamp-round"

  test "the disconnected mount renders an uninspected round sheet", %{conn: conn} do
    conn = get(conn, @path)
    html = html_response(conn, 200)

    assert html =~ "Cape Disappointment Light"
    assert html =~ "Sigrid"
    assert html =~ "uninspected"
    assert html =~ "No lamp touched this round."
  end

  test "phx-change records the field named in _target", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "first_order_lens"],
      "round" => %{"first_order_lens" => "trimmed"}
    })

    assert has_element?(view, "#last-target", "first_order_lens")
    assert has_element?(view, "#lens-state", "trimmed")
    assert has_element?(view, "#round-lines", "First-order lens set to trimmed")
    refute has_element?(view, "#empty-round")
  end

  test "later changes keep earlier lamps and retarget the sheet", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "first_order_lens"],
      "round" => %{"first_order_lens" => "lit"}
    })

    view
    |> element("#lamp-round-form")
    |> render_change(%{
      "_target" => ["round", "steam_siren"],
      "round" => %{"steam_siren" => "up-to-pressure"}
    })

    assert has_element?(view, "#lens-state", "lit")
    assert has_element?(view, "#siren-state", "up-to-pressure")
    assert has_element?(view, "#last-target", "steam_siren")
    assert has_element?(view, "#round-lines", "Steam siren set to up-to-pressure")
  end
end

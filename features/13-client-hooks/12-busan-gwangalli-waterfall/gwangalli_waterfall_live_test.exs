defmodule PhoenixMultivitaminWeb.BusanGwangalliWaterfallLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/12-busan-gwangalli-waterfall"

  test "the reused hook is scoped by instrument ID and carries slot legends", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#air-waterfall[phx-hook$='.Waterfall'][phx-update='ignore'][data-station='Gwangalli air training']")
    assert has_element?(view, "#air-waterfall [data-waterfall-legend]", "AIR rescue training")
    assert has_element?(view, "#ground-waterfall [data-waterfall-legend]", "GROUND crew training")
    view |> element("#scan-air") |> render_click()
    assert_push_event view, "busan:spectrum", %{
      scope: "air-waterfall",
      bins: [%{mhz: 122, strength: 8}, %{mhz: 125, strength: 4}, %{mhz: 128, strength: 10}],
      peak_mhz: 128
    }
    view |> element("#scan-ground") |> render_click()
    assert_push_event view, "busan:spectrum", %{scope: "ground-waterfall", peak_mhz: 126}
    assert has_element?(view, "#scan-status", "ground: 2")
  end

  test "an unlisted receiver cannot push a spectrum", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "scan_gwangalli", %{"band" => "marine"})
    assert has_element?(view, "#scan-status", "air or ground")
    refute_push_event view, "busan:spectrum", _spectrum
  end
end

defmodule PhoenixMultivitaminWeb.PenangGeorgeTownCrankLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/06-penang-george-town-crank"

  test "hook targeting keeps each tug's crank independent", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#north-tug-hook[phx-hook$='.TowbarCrank'][phx-target][data-target='#north-tug']")
    view |> element("#north-tug-hook") |> render_hook("crank_towbar", %{"direction" => "tighten"})
    assert_reply view, %{accepted: true, turns: 1}
    assert has_element?(view, "#north-tug-turns", "1")
    assert has_element?(view, "#south-tug-turns", "0")
  end

  test "a ratchet stop and an unknown direction return rejection replies", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    view |> element("#south-tug-hook") |> render_hook("crank_towbar", %{"direction" => "release"})
    assert_reply view, %{accepted: false, reason: "ratchet_stop"}
    view |> element("#south-tug-hook") |> render_hook("crank_towbar", %{"direction" => "spin"})
    assert_reply view, %{accepted: false, reason: "unknown_direction"}
    assert has_element?(view, "#south-tug-turns", "0")
  end
end

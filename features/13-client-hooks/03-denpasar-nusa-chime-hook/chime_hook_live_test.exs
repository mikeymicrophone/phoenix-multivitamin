defmodule PhoenixMultivitaminWeb.DenpasarNusaChimeHookLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/03-denpasar-nusa-chime-hook"

  test "packing and unpacking removes and remounts the hook node", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#nusa-bell[phx-hook$='.BoardingChime'][phx-update='ignore']")
    view |> element("#pack-bell") |> render_click()
    refute has_element?(view, "#nusa-bell")
    assert has_element?(view, "#ring-nusa[disabled]")
    render_hook(view, "hear_boarding_chime", %{"strikes" => 2})
    assert has_element?(view, "#chime-count", "0 strikes")
    assert has_element?(view, "#chime-status", "Unpack the bell")
    view |> element("#pack-bell") |> render_click()
    assert has_element?(view, "#nusa-bell")
    refute has_element?(view, "#ring-nusa[disabled]")
  end

  test "hook strikes are counted while invalid payloads are rejected", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "hear_boarding_chime", %{"strikes" => 2})
    assert has_element?(view, "#chime-count", "2 strikes")
    render_hook(view, "hear_boarding_chime", %{"strikes" => 8})
    assert has_element?(view, "#chime-count", "2 strikes")
    assert has_element?(view, "#chime-status", "one to three")
  end
end

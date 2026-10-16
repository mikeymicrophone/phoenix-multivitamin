defmodule PhoenixMultivitaminWeb.LangkawiCableBellsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/07-langkawi-cable-bells"

  test "a tuple program becomes dataset settings without replacing hook children", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#cable-bell[phx-hook$='.CableBell'][phx-update='ignore'][data-cadence-ms='2400']")
    view |> element("#ridge-program") |> render_click()
    assert has_element?(view, "#cable-bell[data-cadence-ms='1200'][data-bell-label='Ridge rescue']")
    view |> element("#shore-program") |> render_click()
    assert has_element?(view, "#cable-bell[data-cadence-ms='2400']")
  end

  test "a missing program leaves the cadence unchanged", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "set_bell_program", %{"program" => "summit"})
    assert has_element?(view, "#bell-program-status", "ridge or shore")
    assert has_element?(view, "#cable-bell[data-cadence-ms='2400']")
  end
end

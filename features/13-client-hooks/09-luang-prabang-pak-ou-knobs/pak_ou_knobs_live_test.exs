defmodule PhoenixMultivitaminWeb.LuangPrabangPakOuKnobsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/09-luang-prabang-pak-ou-knobs"

  test "a hook updates only its aircraft and parking deletes the stable stream row", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    assert has_element?(view, "#propeller-rack[phx-update='stream']")
    assert has_element?(view, "#propeller-rdpl-341[phx-hook$='.PropellerKnob'][phx-update='ignore']")
    render_hook(view, "set_propeller", %{"aircraft" => "rdpl-341", "rpm" => 1700})
    assert has_element?(view, "#propeller-rdpl-341[data-rpm='1700']")
    assert has_element?(view, "#propeller-rdpl-342[data-rpm='1600']")
    view |> element("#park-rdpl-341") |> render_click()
    refute has_element?(view, "#propeller-rdpl-341")
    render_hook(view, "set_propeller", %{"aircraft" => "rdpl-341", "rpm" => 1800})
    refute has_element?(view, "#propeller-rdpl-341")
    assert has_element?(view, "#propeller-status", "left the inspection rack")
    view |> element("#park-rdpl-342") |> render_click()
    assert has_element?(view, "#propeller-rack > #empty-rack:only-child")
  end

  test "invalid speeds and repeat removals do not recreate aircraft", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "set_propeller", %{"aircraft" => "rdpl-341", "rpm" => 2000})
    assert has_element?(view, "#propeller-rdpl-341[data-rpm='1500']")
    assert has_element?(view, "#propeller-status", "1000 to 1900")
    render_hook(view, "park_aircraft", %{"aircraft" => "rdpl-399"})
    assert has_element?(view, "#propeller-status", "already parked")
    render_hook(view, "park_aircraft", %{})
    assert has_element?(view, "#propeller-status", "Choose an aircraft")
  end
end

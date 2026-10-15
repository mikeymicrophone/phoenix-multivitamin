defmodule PhoenixMultivitaminWeb.KaleetanTrailPermitsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/10-kaleetan-trail-permits"

  test "assign_new picks h3 for a day slip and intersperse prints the party", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Denny Creek"
    assert html =~ "Thea"
    assert has_element?(view, "h3#permit-heading", "day permit")
    refute has_element?(view, "h2#permit-heading")
    assert has_element?(view, "#party-line", "Thea")
    assert has_element?(view, "#party-line", "Nils")
    assert has_element?(view, "#party-line", "Petra")
    assert has_element?(view, "#ranger-used", "ranger field untouched")
    assert has_element?(view, "#party-count", "3 in the party")
  end

  test "overnight switches the dynamic tag and update/3 appends Soren", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#switch-overnight") |> render_click()
    assert has_element?(view, "h2#permit-heading", "overnight permit")
    refute has_element?(view, "h3#permit-heading")

    view |> element("#add-soren") |> render_click()
    assert has_element?(view, "#party-line", "Soren")
    assert has_element?(view, "#party-count", "4 in the party")
  end

  test "used_input?/1 stays false until the ranger field changes", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#ranger-used", "ranger field untouched")
    view |> element("#ranger-form") |> render_change(%{"permit" => %{"ranger" => "Nils"}})
    assert has_element?(view, "#ranger-used", "ranger field used")
  end

  test "seeding to_form/2 with the ranger name makes used_input?/1 true" do
    seeded = Phoenix.Component.to_form(%{"ranger" => "Thea"}, as: :permit)
    empty = Phoenix.Component.to_form(%{}, as: :permit)

    assert Phoenix.Component.used_input?(seeded[:ranger])
    refute Phoenix.Component.used_input?(empty[:ranger])
  end
end

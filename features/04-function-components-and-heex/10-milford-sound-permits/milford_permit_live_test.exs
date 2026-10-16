defmodule PhoenixMultivitaminWeb.MilfordSoundPermitsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/10-milford-sound-permits"

  test "assign_new picks h3 for a scenic slip and intersperse prints the party", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Milford Sound airstrip"
    assert html =~ "Ngaio"
    assert has_element?(view, "h3#permit-heading", "scenic permit")
    refute has_element?(view, "h2#permit-heading")
    assert has_element?(view, "#party-line", "Ngaio")
    assert has_element?(view, "#party-line", "Kahu")
    assert has_element?(view, "#party-line", "Anahera")
    assert has_element?(view, "#dispatcher-used", "dispatcher field untouched")
    assert has_element?(view, "#party-count", "3 in the party")
  end

  test "overnight switches the dynamic tag and update/3 appends Hemi", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#switch-overnight") |> render_click()
    assert has_element?(view, "h2#permit-heading", "overnight permit")
    refute has_element?(view, "h3#permit-heading")

    view |> element("#add-hemi") |> render_click()
    assert has_element?(view, "#party-line", "Hemi")
    assert has_element?(view, "#party-count", "4 in the party")
  end

  test "used_input?/1 stays false until the dispatcher field changes", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    assert has_element?(view, "#dispatcher-used", "dispatcher field untouched")
    view |> element("#dispatcher-form") |> render_change(%{"permit" => %{"dispatcher" => "Kahu"}})
    assert has_element?(view, "#dispatcher-used", "dispatcher field used")
  end

  test "seeding to_form/2 with the dispatcher name makes used_input?/1 true" do
    seeded = Phoenix.Component.to_form(%{"dispatcher" => "Ngaio"}, as: :permit)
    empty = Phoenix.Component.to_form(%{}, as: :permit)

    assert Phoenix.Component.used_input?(seeded[:dispatcher])
    refute Phoenix.Component.used_input?(empty[:dispatcher])
  end
end

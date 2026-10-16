defmodule PhoenixMultivitaminWeb.EilatDesertBannerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/05-core-components-and-layouts/04-eilat-desert-banner"

  test "the overridden input class replaces the default input classes", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#qnh-field")
    assert html =~ "border-amber-600"
    assert html =~ "Noa"
    assert html =~ "King Air 350"
    refute html =~ ~s(class="w-full input")
    refute html =~ "input-error"
  end

  test "the field still posts QNH after the class override", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_change(element(view, "#qnh-form"), %{"qnh" => "1008"})
    assert has_element?(view, "#posted-qnh", "1008")
  end
end

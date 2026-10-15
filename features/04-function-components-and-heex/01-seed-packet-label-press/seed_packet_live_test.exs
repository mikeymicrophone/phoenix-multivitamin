defmodule PhoenixMultivitaminWeb.SeedPacketLabelPressLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.SeedPacketLabelPressLive

  @path "/features/04-function-components-and-heex/01-seed-packet-label-press"

  test "the press prints required attrs and fills defaults", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Sequim"
    assert html =~ "Linnea"
    assert has_element?(view, "#chioggia-packet [data-field=lot]", "NASH-24-081")
    assert has_element?(view, "#chioggia-packet [data-field=grams]", "3 g")
    assert has_element?(view, "#chioggia-packet [data-field=kind]", "heirloom")
    assert has_element?(view, "#chioggia-packet [data-field=organic]", "certified organic")
    assert has_element?(view, "#lima-packet [data-field=grams]", "4 g")
    assert has_element?(view, "#lettuce-packet [data-field=organic]", "not claimed")
    assert has_element?(view, "#lettuce-packet [data-field=kind]", "hybrid")
  end

  test "stamping Chioggia as hybrid updates only the values: attr", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#stamp-hybrid-chioggia") |> render_click()
    assert has_element?(view, "#chioggia-packet [data-field=kind]", "hybrid")
    assert has_element?(view, "#lima-packet [data-field=kind]", "open-pollinated")

    view |> element("#stamp-heirloom-chioggia") |> render_click()
    assert has_element?(view, "#chioggia-packet [data-field=kind]", "heirloom")
  end

  test "passing nil for grams does not restore the default of 3", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#weigh-lima-empty") |> render_click()
    assert has_element?(view, "#lima-packet [data-field=grams]", "scale empty")
    refute has_element?(view, "#lima-packet [data-field=grams]", "3 g")

    view |> element("#weigh-lima-default") |> render_click()
    assert has_element?(view, "#lima-packet [data-field=grams]", "4 g")
  end

  test "a direct call still receives attr defaults from the generated wrapper" do
    html =
      render_component(&SeedPacketLabelPressLive.packet_label/1, %{
        id: "direct-packet",
        variety: "Traverso kale",
        lot: "NASH-24-330"
      })

    assert html =~ "Traverso kale"
    assert html =~ "3 g"
    assert html =~ "heirloom"
    assert html =~ "certified organic"
  end
end

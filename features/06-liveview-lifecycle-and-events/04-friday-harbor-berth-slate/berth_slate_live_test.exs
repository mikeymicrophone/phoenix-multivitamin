defmodule PhoenixMultivitaminWeb.FridayHarborBerthSlateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/04-friday-harbor-berth-slate"

  test "phx-change previews a berth and includes _target", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Friday Harbor"
    assert has_element?(view, "#harbormaster-name", "Nell")
    assert has_element?(view, "#empty-slate")

    view
    |> element("#berth-slate-form")
    |> render_change(%{
      "_target" => ["slate", "vessel"],
      "slate" => %{"vessel" => "M/V Kirkland", "slip" => "A-12"}
    })

    assert has_element?(view, "#last-event", "preview_berth")
    assert has_element?(view, "#had-target", "yes")
    assert has_element?(view, "#berth-preview", "M/V Kirkland standing by for A-12")
    assert has_element?(view, "#empty-slate")
  end

  test "phx-submit posts the berth and does not send _target", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#berth-slate-form")
    |> render_submit(%{"slate" => %{"vessel" => "M/V Kirkland", "slip" => "A-12"}})

    assert has_element?(view, "#last-event", "assign_berth")
    assert has_element?(view, "#had-target", "no")
    assert has_element?(view, "#posted-berths", "M/V Kirkland at A-12")
    refute has_element?(view, "#empty-slate")
  end

  test "submit refuses a second vessel on an occupied slip", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#berth-slate-form")
    |> render_submit(%{"slate" => %{"vessel" => "M/V Kirkland", "slip" => "B-3"}})

    view
    |> element("#berth-slate-form")
    |> render_submit(%{"slate" => %{"vessel" => "Western Flyer", "slip" => "B-3"}})

    assert has_element?(view, "#berth-error", "B-3 already holds M/V Kirkland")
    refute has_element?(view, "#posted-berths", "Western Flyer")
  end
end

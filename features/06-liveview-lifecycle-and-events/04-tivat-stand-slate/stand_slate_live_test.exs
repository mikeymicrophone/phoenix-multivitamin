defmodule PhoenixMultivitaminWeb.TivatStandSlateLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/06-liveview-lifecycle-and-events/04-tivat-stand-slate"

  test "phx-change previews a stand and includes _target", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Tivat"
    assert has_element?(view, "#clerk-name", "Ivana")
    assert has_element?(view, "#empty-slate")

    view
    |> element("#stand-slate-form")
    |> render_change(%{
      "_target" => ["slate", "tail"],
      "slate" => %{"tail" => "9H-TIV", "stand" => "A-12"}
    })

    assert has_element?(view, "#last-event", "preview_stand")
    assert has_element?(view, "#had-target", "yes")
    assert has_element?(view, "#stand-preview", "9H-TIV standing by for A-12")
    assert has_element?(view, "#empty-slate")
  end

  test "phx-submit posts the stand and does not send _target", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#stand-slate-form")
    |> render_submit(%{"slate" => %{"tail" => "9H-TIV", "stand" => "A-12"}})

    assert has_element?(view, "#last-event", "assign_stand")
    assert has_element?(view, "#had-target", "no")
    assert has_element?(view, "#posted-stands", "9H-TIV at A-12")
    refute has_element?(view, "#empty-slate")
  end

  test "submit refuses a second tail on an occupied stand", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view
    |> element("#stand-slate-form")
    |> render_submit(%{"slate" => %{"tail" => "9H-TIV", "stand" => "B-3"}})

    view
    |> element("#stand-slate-form")
    |> render_submit(%{"slate" => %{"tail" => "OE-IVN", "stand" => "B-3"}})

    assert has_element?(view, "#stand-error", "B-3 already holds 9H-TIV")
    refute has_element?(view, "#posted-stands", "OE-IVN")
  end
end

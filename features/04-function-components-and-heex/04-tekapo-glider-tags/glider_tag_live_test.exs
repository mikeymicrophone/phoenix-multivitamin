defmodule PhoenixMultivitaminWeb.TekapoGliderTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/04-tekapo-glider-tags"

  test ":for prints every glider and :let yields the glider into the inner_block", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Lake Tekapo"
    assert html =~ "Miriama"
    assert has_element?(view, "#glider-12", "6 hours")
    assert has_element?(view, "#glider-12", "2 nights")
    assert has_element?(view, "#glider-19", "short wait")
    assert has_element?(view, "#glider-27", "9 hours")
  end

  test ":if hides holding gliders and dropping a glider removes its tag", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#hide-holding") |> render_click()
    assert has_element?(view, "#glider-12")
    assert has_element?(view, "#glider-27")
    refute has_element?(view, "#glider-19")

    view |> element("#show-holding") |> render_click()
    assert has_element?(view, "#glider-19")

    view |> element("#pull-glider-19") |> render_click()
    refute has_element?(view, "#glider-19")
    assert has_element?(view, "#glider-12")
  end
end

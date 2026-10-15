defmodule PhoenixMultivitaminWeb.DungenessCrabPotTagsLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/04-function-components-and-heex/04-dungeness-crab-pot-tags"

  test ":for prints every pot and :let yields the pot into the inner_block", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Dungeness Bay"
    assert html =~ "Harlan"
    assert has_element?(view, "#pot-12", "6 keepers")
    assert has_element?(view, "#pot-12", "2 nights")
    assert has_element?(view, "#pot-19", "short soak")
    assert has_element?(view, "#pot-27", "9 keepers")
  end

  test ":if hides soaking pots and dropping a pot removes its tag", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)

    view |> element("#hide-soaking") |> render_click()
    assert has_element?(view, "#pot-12")
    assert has_element?(view, "#pot-27")
    refute has_element?(view, "#pot-19")

    view |> element("#show-soaking") |> render_click()
    assert has_element?(view, "#pot-19")

    view |> element("#pull-pot-19") |> render_click()
    refute has_element?(view, "#pot-19")
    assert has_element?(view, "#pot-12")
  end
end

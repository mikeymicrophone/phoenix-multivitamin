defmodule PhoenixMultivitaminWeb.BushPointRangeBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.BushPointRangeBoardLive

  @path "/features/02-verified-routes/02-bush-point-range-board"

  test "keyword lists and maps encode the same sorted query string" do
    keyword_path = BushPointRangeBoardLive.range_query_path(light: "rear", bearing: "187")
    map_path = BushPointRangeBoardLive.range_query_path(%{"bearing" => "187", "light" => "rear"})

    assert keyword_path == "#{@path}?bearing=187&light=rear"
    assert map_path == keyword_path
    assert BushPointRangeBoardLive.board_path() == @path
    refute BushPointRangeBoardLive.board_path() =~ "?"
  end

  test "spaces in query values are encoded rather than concatenated raw" do
    path = BushPointRangeBoardLive.range_query_path(light: "front", note: "west bank")
    assert path == "#{@path}?light=front&note=west+bank"
  end

  test "the board reads light and bearing from the verified query", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Bush Point Range"
    assert html =~ "Ned"
    assert has_element?(view, "#range-light", "front")
    assert has_element?(view, "#range-bearing", "187° true")
    assert has_element?(view, "#keyword-query-path", "#{@path}?bearing=187&light=rear")
    assert has_element?(view, "#map-query-path", "#{@path}?bearing=187&light=rear")
    assert has_element?(view, "#spaced-query-path", "note=west+bank")
    assert has_element?(view, "#bare-board-path", @path)

    view |> element("#show-rear") |> render_click()
    assert_patch(view, "#{@path}?bearing=187&light=rear")
    assert has_element?(view, "#range-light", "rear")
    assert has_element?(view, "#range-copy", "rear light, bearing 187")

    view |> element("#front-range-link") |> render_click()
    assert_patch(view, "#{@path}?bearing=187&light=front")
    assert has_element?(view, "#range-light", "front")
  end
end

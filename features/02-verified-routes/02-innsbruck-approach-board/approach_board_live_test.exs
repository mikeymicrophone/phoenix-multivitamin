defmodule PhoenixMultivitaminWeb.InnsbruckApproachBoardLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.InnsbruckApproachBoardLive

  @path "/features/02-verified-routes/02-innsbruck-approach-board"

  test "keyword lists and maps encode the same sorted query string" do
    keyword_path = InnsbruckApproachBoardLive.approach_query_path(loc: "outer", radial: "256")
    map_path = InnsbruckApproachBoardLive.approach_query_path(%{"radial" => "256", "loc" => "outer"})

    assert keyword_path == "#{@path}?loc=outer&radial=256"
    assert map_path == keyword_path
    assert InnsbruckApproachBoardLive.board_path() == @path
    refute InnsbruckApproachBoardLive.board_path() =~ "?"
  end

  test "spaces in query values are encoded rather than concatenated raw" do
    path = InnsbruckApproachBoardLive.approach_query_path(loc: "inner", note: "inn valley")
    assert path == "#{@path}?loc=inner&note=inn+valley"
  end

  test "the board reads loc and radial from the verified query", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Innsbruck approach"
    assert html =~ "Lena"
    assert has_element?(view, "#approach-loc", "inner")
    assert has_element?(view, "#approach-radial", "256° inbound")
    assert has_element?(view, "#keyword-query-path", "#{@path}?loc=outer&radial=256")
    assert has_element?(view, "#map-query-path", "#{@path}?loc=outer&radial=256")
    assert has_element?(view, "#spaced-query-path", "note=inn+valley")
    assert has_element?(view, "#bare-board-path", @path)

    view |> element("#show-outer") |> render_click()
    assert_patch(view, "#{@path}?loc=outer&radial=256")
    assert has_element?(view, "#approach-loc", "outer")
    assert has_element?(view, "#approach-copy", "outer marker, radial 256")

    view |> element("#inner-approach-link") |> render_click()
    assert_patch(view, "#{@path}?loc=inner&radial=256")
    assert has_element?(view, "#approach-loc", "inner")
  end
end

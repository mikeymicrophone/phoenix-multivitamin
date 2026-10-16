defmodule PhoenixMultivitaminWeb.NairobiWilsonFareBannerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.NairobiWilsonFareBannerLive

  @banner "/features/02-verified-routes/11-nairobi-wilson-fare-banner"
  @lane_two "/features/02-verified-routes/11-nairobi-wilson-fare-banner/lanes/2"

  test "Router.Helpers was not generated; named functions wrap ~p instead" do
    refute Code.ensure_loaded?(PhoenixMultivitaminWeb.Router.Helpers)
    assert NairobiWilsonFareBannerLive.fare_board_path() == @banner
    assert NairobiWilsonFareBannerLive.vehicle_lane_path(2) == @lane_two

    assert NairobiWilsonFareBannerLive.vehicle_lane_path("3") ==
             "/features/02-verified-routes/11-nairobi-wilson-fare-banner/lanes/3"
  end

  test "the banner navigates through the named ~p wrappers", %{conn: conn} do
    {:ok, view, html} = live(conn, @banner)

    assert html =~ "Wilson Airport"
    assert html =~ "Amina"
    assert has_element?(view, "#lane-name", "walk-on")
    assert has_element?(view, "#banner-path", @banner)
    assert has_element?(view, "#lane-two-path", @lane_two)

    {:ok, lane_view, _html} =
      view
      |> element("#lane-two-link")
      |> render_click()
      |> follow_redirect(conn, @lane_two)

    assert has_element?(lane_view, "#lane-name", "2")
    assert has_element?(lane_view, "#surface-banner", "Stand lane 2")
    assert has_element?(lane_view, "#fare-copy", "2 through a named function")
  end
end

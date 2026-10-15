defmodule PhoenixMultivitaminWeb.MukilteoFareBannerLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.MukilteoFareBannerLive

  @banner "/features/02-verified-routes/11-mukilteo-fare-banner"
  @lane_two "/features/02-verified-routes/11-mukilteo-fare-banner/lanes/2"

  test "Router.Helpers was not generated; named functions wrap ~p instead" do
    refute Code.ensure_loaded?(PhoenixMultivitaminWeb.Router.Helpers)
    assert MukilteoFareBannerLive.fare_board_path() == @banner
    assert MukilteoFareBannerLive.vehicle_lane_path(2) == @lane_two

    assert MukilteoFareBannerLive.vehicle_lane_path("3") ==
             "/features/02-verified-routes/11-mukilteo-fare-banner/lanes/3"
  end

  test "the banner navigates through the named ~p wrappers", %{conn: conn} do
    {:ok, view, html} = live(conn, @banner)

    assert html =~ "Mukilteo ferry terminal"
    assert html =~ "Ysolde"
    assert has_element?(view, "#lane-name", "walk-on")
    assert has_element?(view, "#banner-path", @banner)
    assert has_element?(view, "#lane-two-path", @lane_two)

    {:ok, lane_view, _html} =
      view
      |> element("#lane-two-link")
      |> render_click()
      |> follow_redirect(conn, @lane_two)

    assert has_element?(lane_view, "#lane-name", "2")
    assert has_element?(lane_view, "#surface-banner", "Vehicle lane 2")
    assert has_element?(lane_view, "#fare-copy", "2 through a named function")
  end
end

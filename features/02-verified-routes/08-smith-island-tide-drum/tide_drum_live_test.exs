defmodule PhoenixMultivitaminWeb.SmithIslandTideDrumLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.SmithIslandTideDrumController
  alias PhoenixMultivitaminWeb.SmithIslandTideDrumLive

  @path "/features/02-verified-routes/08-smith-island-tide-drum"
  @island_host "/features/02-verified-routes/08-smith-island-tide-drum/island-host"

  test "url/1 uses the endpoint; url/2 with a URI uses the island host" do
    assert SmithIslandTideDrumLive.drum_path() == @path

    assert url(~p"/features/02-verified-routes/08-smith-island-tide-drum") ==
             PhoenixMultivitaminWeb.Endpoint.url() <> @path

    assert url(~p"/features/02-verified-routes/08-smith-island-tide-drum") =~ ":4000"
    refute url(~p"/features/02-verified-routes/08-smith-island-tide-drum") =~ "4002"

    assert url(
             SmithIslandTideDrumLive.island_uri(),
             ~p"/features/02-verified-routes/08-smith-island-tide-drum"
           ) ==
             "https://tidedrum.smithisland.wa.gov#{@path}"
  end

  test "put_router_url/2 on the conn overrides the host for url/2", %{conn: conn} do
    assert SmithIslandTideDrumController.island_host_path() == @island_host

    conn = get(conn, @island_host)
    assert text_response(conn, 200) == "https://tidedrum.smithisland.wa.gov#{@path}"
  end

  test "the tide drum shows path, endpoint URL, and island URL", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Smith Island Light"
    assert html =~ "Calder"
    assert has_element?(view, "#drum-path", @path)
    assert has_element?(view, "#endpoint-url", PhoenixMultivitaminWeb.Endpoint.url() <> @path)
    assert has_element?(view, "#island-url", "https://tidedrum.smithisland.wa.gov#{@path}")
    assert has_element?(view, "#island-host-path", @island_host)
    refute has_element?(view, "#endpoint-url", "4002")
    assert has_element?(view, "#endpoint-url", ":4000")
  end
end

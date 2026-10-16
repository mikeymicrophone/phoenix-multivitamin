defmodule PhoenixMultivitaminWeb.MataveriMetarDrumLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitaminWeb.MataveriMetarDrumController
  alias PhoenixMultivitaminWeb.MataveriMetarDrumLive

  @path "/features/02-verified-routes/08-mataveri-metar-drum"
  @island_host "/features/02-verified-routes/08-mataveri-metar-drum/island-host"

  test "url/1 uses the endpoint; url/2 with a URI uses the island host" do
    assert MataveriMetarDrumLive.drum_path() == @path

    assert url(~p"/features/02-verified-routes/08-mataveri-metar-drum") ==
             PhoenixMultivitaminWeb.Endpoint.url() <> @path

    assert url(~p"/features/02-verified-routes/08-mataveri-metar-drum") =~ ":4000"
    refute url(~p"/features/02-verified-routes/08-mataveri-metar-drum") =~ "4002"

    assert url(
             MataveriMetarDrumLive.island_uri(),
             ~p"/features/02-verified-routes/08-mataveri-metar-drum"
           ) ==
             "https://metar.mataveri.cl#{@path}"
  end

  test "put_router_url/2 on the conn overrides the host for url/2", %{conn: conn} do
    assert MataveriMetarDrumController.island_host_path() == @island_host

    conn = get(conn, @island_host)
    assert text_response(conn, 200) == "https://metar.mataveri.cl#{@path}"
  end

  test "the METAR drum shows path, endpoint URL, and island URL", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)

    assert html =~ "Mataveri METAR drum"
    assert html =~ "Hina"
    assert has_element?(view, "#drum-path", @path)
    assert has_element?(view, "#endpoint-url", PhoenixMultivitaminWeb.Endpoint.url() <> @path)
    assert has_element?(view, "#island-url", "https://metar.mataveri.cl#{@path}")
    assert has_element?(view, "#island-host-path", @island_host)
    refute has_element?(view, "#endpoint-url", "4002")
    assert has_element?(view, "#endpoint-url", ":4000")
  end
end

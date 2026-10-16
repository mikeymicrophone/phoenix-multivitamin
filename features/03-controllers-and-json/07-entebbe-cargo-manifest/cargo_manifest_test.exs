defmodule PhoenixMultivitaminWeb.EntebbeCargoManifestTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/07-entebbe-cargo-manifest"
  @new @map <> "/manifests/new"
  @create @map <> "/manifests"
  @show @map <> "/manifests/brussels-il76"

  test "the catalog page links new and the Brussels pallet", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-new-manifest")
    assert Phoenix.LiveViewTest.has_element?(view, "#open-brussels-manifest")
  end

  test "show/2 renders the filed Il-76 pallet", %{conn: conn} do
    conn = get(conn, @show)
    html = html_response(conn, 200)
    assert html =~ "Brussels"
    assert html =~ "Ilyushin Il-76"
    assert html =~ "Kato"
    assert html =~ "18400"
  end

  test "create/2 redirects to the show path and does not render a created body", %{conn: conn} do
    conn = get(conn, @new)
    html = html_response(conn, 200)
    [_, token] = Regex.run(~r/csrf-token" content="([^"]+)"/, html)

    conn =
      conn
      |> recycle()
      |> post(@create, %{
        "_csrf_token" => token,
        "manifest" => %{"id" => "brussels-il76"}
      })

    assert redirected_to(conn) == @show
    refute conn.resp_body =~ "Ilyushin Il-76"

    conn = get(recycle(conn), redirected_to(conn))
    assert html_response(conn, 200) =~ "relief pallets"
  end
end

defmodule PhoenixMultivitaminWeb.KaohsiungLoveRiverScopeLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/13-client-hooks/11-kaohsiung-love-river-scope"

  test "the HTTP render offers a fallback and no river hook", %{conn: conn} do
    document = conn |> get(@path) |> html_response(200) |> LazyHTML.from_document()
    assert document |> LazyHTML.query("#scope-static") |> LazyHTML.to_html() != ""
    assert document |> LazyHTML.query("#love-river-scope") |> LazyHTML.to_html() == ""
  end

  test "only the connected hook handshake arms the first sweep", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    refute has_element?(view, "#scope-static")
    assert has_element?(view, "#love-river-scope[phx-hook$='.RiverScope'][phx-update='ignore']")
    assert has_element?(view, "#river-scope-status", "awaiting handshake")
    render_hook(view, "arm_river_scope", %{"channel" => "river"})
    assert_reply view, %{armed: true}
    assert_push_event view, "kaohsiung:sweep", %{bearings: [15, 45, 80], range_km: 6}
    assert has_element?(view, "#river-scope-status", "armed")
  end

  test "unknown scope channels cannot arm the sweep", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_hook(view, "arm_river_scope", %{"channel" => "harbour"})
    assert_reply view, %{armed: false, reason: "unknown_scope"}
    refute_push_event view, "kaohsiung:sweep", _sweep
  end
end

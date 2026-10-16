defmodule PhoenixMultivitaminWeb.KangerlussuaqSoundingShelfLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitamin.KangerlussuaqSounding
  alias PhoenixMultivitamin.Repo

  @path "/features/08-async-assigns/09-kangerlussuaq-sounding-shelf"

  test "stream_async reads the sounding row without blocking the dead render", %{conn: conn} do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    {:ok, _} =
      Repo.insert(%KangerlussuaqSounding{
        clerk: "Malik",
        craft: "Airbus A330-200",
        oat_c: -31,
        inserted_at: now,
        updated_at: now
      })

    html = html_response(get(conn, @path), 200)
    assert html =~ "Kangerlussuaq sounding shelf"
    assert html =~ "Malik"
    assert html =~ "Shelf still opening."
    refute html =~ "-31"

    {:ok, view, _html} = live(conn, @path)
    html = render_async(view)
    assert html =~ "-31"
    assert has_element?(view, "#sounding-oat", "-31")
    refute has_element?(view, "#sounding-loading")
    assert has_element?(view, "#craft-name", "Airbus A330-200")
  end

  test "an empty shelf finishes loading without inserting a row", %{conn: conn} do
    {:ok, view, _html} = live(conn, @path)
    render_async(view)

    assert has_element?(view, "#sounding-ready")
    assert has_element?(view, "#soundings > #sounding-empty")
    refute has_element?(view, "#soundings > article")
    refute has_element?(view, "#sounding-loading")
  end
end

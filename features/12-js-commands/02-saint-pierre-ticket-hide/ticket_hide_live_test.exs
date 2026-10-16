defmodule PhoenixMultivitaminWeb.SaintPierreTicketHideLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @path "/features/12-js-commands/02-saint-pierre-ticket-hide"

  test "show and hide commands target the drift ticket", %{conn: conn} do
    {:ok, view, html} = live(conn, @path)
    assert has_element?(view, "#clerk-name", "Léonie")
    assert html =~ "show"
    assert html =~ "hide"
    assert html =~ "#drift-ticket"
  end
end

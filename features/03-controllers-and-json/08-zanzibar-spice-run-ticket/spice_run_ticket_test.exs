defmodule PhoenixMultivitaminWeb.ZanzibarSpiceRunTicketTest do
  use PhoenixMultivitaminWeb.ConnCase

  @map "/features/03-controllers-and-json/08-zanzibar-spice-run-ticket"
  @tickets @map <> "/tickets"

  test "the catalog page links the ticket index", %{conn: conn} do
    {:ok, view, _html} = Phoenix.LiveViewTest.live(conn, @map)
    assert Phoenix.LiveViewTest.has_element?(view, "#open-tickets")
  end

  test "index/2 is a JSON collection with three spice-run tickets", %{conn: conn} do
    conn = get(conn, @tickets)
    body = json_response(conn, 200)
    assert body["station"] == "HTZA"
    assert body["clerk"] == "Asha"
    assert length(body["tickets"]) == 3
    assert Enum.any?(body["tickets"], &(&1["id"] == "clove-06"))
    assert Enum.any?(body["tickets"], &(&1["cargo"] == "cinnamon bales"))
    assert Enum.all?(body["tickets"], &(&1["craft"] == "Let L-410"))
  end
end

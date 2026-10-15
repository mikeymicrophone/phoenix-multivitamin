defmodule PhoenixMultivitaminWeb.CatalogLiveTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PhoenixMultivitamin.Catalog

  test "the catalog lists every feature and the bottled count", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")

    [bottled] = Catalog.bottled_slots()

    assert html =~ "Phoenix Multivitamin"
    assert html =~ "1 of 325"
    assert html =~ "Routing and plugs"
    assert html =~ "LiveView lifecycle and events"
    assert html =~ "Testing"
    assert html =~ bottled.title
  end

  test "every slot has a page", %{conn: conn} do
    for feature <- Catalog.features(), slot <- feature.slots do
      conn = get(conn, slot.path)
      assert html_response(conn, 200) =~ slot.title
    end
  end

  test "a planned slot says it is planned", %{conn: conn} do
    slot =
      Catalog.features()
      |> hd()
      |> Map.fetch!(:slots)
      |> Enum.find(&(not &1.bottled))

    {:ok, _view, html} = live(conn, slot.path)
    assert html =~ "planned"
    assert html =~ slot.title
  end
end

defmodule PhoenixMultivitaminWeb.AnacortesRetortFloorTest do
  use PhoenixMultivitaminWeb.ConnCase

  @floor "/features/01-routing-and-plugs/08-anacortes-retort-floor/floor/cooks"
  @api "/features/01-routing-and-plugs/08-anacortes-retort-floor/api/cooks"

  test "the browser pipeline renders the cannery floor as HTML", %{conn: conn} do
    conn = get(conn, @floor)
    html = html_response(conn, 200)

    assert html =~ "Pacific American Cannery"
    assert html =~ "retort 12"
    assert html =~ "sockeye halves"
    assert html =~ "Veda"
  end

  test "the API pipeline renders the same cooks as JSON", %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get(@api)

    body = json_response(conn, 200)

    assert body["cannery"] == "Pacific American Cannery"
    assert Enum.any?(body["cooks"], &(&1["id"] == "sockeye-12"))
  end

  test "a single cook is JSON under the API prefix and HTML on the floor", %{conn: conn} do
    html_conn = get(conn, @floor <> "/razor-3")
    assert html_response(html_conn, 200) =~ "razor clams"

    json_conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get(@api <> "/razor-3")

    body = json_response(json_conn, 200)
    assert body["cook"]["pack"] == "razor clams"
    assert body["cook"]["minutes"] == 60
  end

  test "an HTML Accept on the API pipeline is not acceptable", %{conn: conn} do
    assert_error_sent 406, fn ->
      conn
      |> put_req_header("accept", "text/html")
      |> get(@api)
    end
  end
end

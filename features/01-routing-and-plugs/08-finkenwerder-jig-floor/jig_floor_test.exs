defmodule PhoenixMultivitaminWeb.FinkenwerderJigFloorTest do
  use PhoenixMultivitaminWeb.ConnCase

  @floor "/features/01-routing-and-plugs/08-finkenwerder-jig-floor/floor/jigs"
  @api "/features/01-routing-and-plugs/08-finkenwerder-jig-floor/api/jigs"

  test "the browser pipeline renders the jig floor as HTML", %{conn: conn} do
    conn = get(conn, @floor)
    html = html_response(conn, 200)

    assert html =~ "Airbus Finkenwerder"
    assert html =~ "wing jig 12"
    assert html =~ "A321neo wingbox"
    assert html =~ "Anke"
  end

  test "the API pipeline renders the same jigs as JSON", %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get(@api)

    body = json_response(conn, 200)

    assert body["plant"] == "Airbus Finkenwerder"
    assert Enum.any?(body["jigs"], &(&1["id"] == "msny-12"))
  end

  test "a single jig is JSON under the API prefix and HTML on the floor", %{conn: conn} do
    html_conn = get(conn, @floor <> "/door-3")
    assert html_response(html_conn, 200) =~ "pax door C"

    json_conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get(@api <> "/door-3")

    body = json_response(json_conn, 200)
    assert body["jig"]["join"] == "pax door C"
    assert body["jig"]["minutes"] == 60
  end

  test "an HTML Accept on the API pipeline is not acceptable", %{conn: conn} do
    assert_error_sent 406, fn ->
      conn
      |> put_req_header("accept", "text/html")
      |> get(@api)
    end
  end
end

defmodule PhoenixMultivitaminWeb.DakarHarmattanMetarTest do
  use PhoenixMultivitaminWeb.ConnCase

  import Phoenix.LiveViewTest

  @map "/features/03-controllers-and-json/06-dakar-harmattan-metar"
  @metar @map <> "/metar"

  test "the catalog page links the harmattan METAR", %{conn: conn} do
    {:ok, view, _html} = live(conn, @map)
    assert has_element?(view, "#open-metar")
  end

  test "a browser Accept renders HTML and get_format/1 is html", %{conn: conn} do
    conn = get(conn, @metar)
    html = html_response(conn, 200)
    assert html =~ "GOBD"
    assert html =~ "Awa"
    assert html =~ "harmattan"
    assert html =~ "html"
  end

  test "Accept application/json selects the JSON body on the same path", %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> get(@metar)

    body = json_response(conn, 200)
    assert body["format"] == "json"
    assert body["metar"]["station"] == "GOBD"
    assert body["metar"]["dust"] == "harmattan"
    assert body["metar"]["craft"] == "Boeing 777-200ER"
  end

  test "an Accept the pipeline does not list is 406", %{conn: conn} do
    assert_error_sent 406, fn ->
      conn
      |> put_req_header("accept", "application/xml")
      |> get(@metar)
    end
  end
end

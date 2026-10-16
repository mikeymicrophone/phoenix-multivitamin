defmodule PhoenixMultivitaminWeb.UshuaiaAustralPipelineTest do
  use PhoenixMultivitaminWeb.ConnCase

  @austral "/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/austral"
  @lookout "/features/01-routing-and-plugs/13-ushuaia-austral-pipeline/lookout"
  @pilar @lookout <> "/clerks/pilar/watches"
  @icing @pilar <> "/icing"
  @midwatch @pilar <> "/midwatch"

  test "the outer austral board runs the austral plug without a lookout ticket", %{conn: conn} do
    conn = get(conn, @austral)
    html = html_response(conn, 200)

    assert html =~ "Ushuaia austral"
    assert html =~ "Tierra del Fuego"
    assert html =~ "Pilar"
    assert html =~ "austral"
    refute html =~ "id=\"trace-lookout\""
    refute html =~ "Martial glacier lookout"
  end

  test "a missing austral ticket halts after the austral plug has already stamped", %{conn: conn} do
    conn = get(conn, @lookout)
    html = html_response(conn, 403)

    assert html =~ "No austral ticket"
    assert html =~ "Ushuaia austral"
    assert html =~ "austral"
    assert html =~ "lookout"
    refute html =~ "austral-radio"
  end

  test "a clear ticket opens the forwarded lookout and nested watches", %{conn: conn} do
    conn = ticketed_get(conn, @lookout)
    html = html_response(conn, 200)

    assert html =~ "Martial glacier lookout"
    assert html =~ "austral-clear"
    assert html =~ "austral-radio"
    assert html =~ "austral"
    assert html =~ "lookout"
  end

  test "resources under /clerks/:clerk list Pilar's watches with string params", %{conn: conn} do
    conn = ticketed_get(conn, @pilar)
    html = html_response(conn, 200)

    assert html =~ "pilar"
    assert html =~ "yes"
    assert html =~ "evening"
    assert html =~ "midwatch"
    assert conn.params["clerk"] == "pilar"
    assert is_binary(conn.params["clerk"])
  end

  test "the icing glass declared before resources is not swallowed as an id", %{conn: conn} do
    conn = ticketed_get(conn, @icing)
    html = html_response(conn, 200)

    assert html =~ "icing glass"
    assert html =~ "Pilar"
    refute html =~ "Martial ice light"
  end

  test "a resource show still serves midwatch as a string id", %{conn: conn} do
    conn = ticketed_get(conn, @midwatch)
    html = html_response(conn, 200)

    assert html =~ "midwatch"
    assert html =~ "Martial ice light"
    assert html =~ "yes"
    assert conn.params["id"] == "midwatch"
  end

  defp ticketed_get(conn, path) do
    conn
    |> put_req_header("x-lookout-ticket", "austral-clear")
    |> get(path)
  end
end

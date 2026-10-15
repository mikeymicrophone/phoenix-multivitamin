defmodule PhoenixMultivitaminWeb.CapeFlatteryPipelineTest do
  use PhoenixMultivitaminWeb.ConnCase

  @cape "/features/01-routing-and-plugs/13-cape-flattery-pipeline/cape"
  @lookout "/features/01-routing-and-plugs/13-cape-flattery-pipeline/lookout"
  @nessa @lookout <> "/keepers/nessa/watches"
  @fog @nessa <> "/fog"
  @midwatch @nessa <> "/midwatch"

  test "the outer cape board runs the cape plug without a lookout ticket", %{conn: conn} do
    conn = get(conn, @cape)
    html = html_response(conn, 200)

    assert html =~ "Cape Flattery"
    assert html =~ "Makah"
    assert html =~ "Chenoa"
    assert html =~ "cape"
    refute html =~ "id=\"trace-lookout\""
    refute html =~ "Tatoosh Island lookout"
  end

  test "a missing Tatoosh ticket halts after the cape plug has already stamped", %{conn: conn} do
    conn = get(conn, @lookout)
    html = html_response(conn, 403)

    assert html =~ "No Tatoosh ticket"
    assert html =~ "Cape Flattery"
    assert html =~ "cape"
    assert html =~ "lookout"
    refute html =~ "tatoosh-radio"
  end

  test "a clear ticket opens the forwarded lookout and nested watches", %{conn: conn} do
    conn = ticketed_get(conn, @lookout)
    html = html_response(conn, 200)

    assert html =~ "Tatoosh Island lookout"
    assert html =~ "tatoosh-clear"
    assert html =~ "tatoosh-radio"
    assert html =~ "cape"
    assert html =~ "lookout"
  end

  test "resources under /keepers/:keeper list Nessa's watches with string params", %{conn: conn} do
    conn = ticketed_get(conn, @nessa)
    html = html_response(conn, 200)

    assert html =~ "nessa"
    assert html =~ "yes"
    assert html =~ "evening"
    assert html =~ "midwatch"
    assert conn.params["keeper"] == "nessa"
    assert is_binary(conn.params["keeper"])
  end

  test "the fog glass declared before resources is not swallowed as an id", %{conn: conn} do
    conn = ticketed_get(conn, @fog)
    html = html_response(conn, 200)

    assert html =~ "fog glass"
    assert html =~ "Nessa"
    refute html =~ "Tatoosh fog signal"
  end

  test "a resource show still serves midwatch as a string id", %{conn: conn} do
    conn = ticketed_get(conn, @midwatch)
    html = html_response(conn, 200)

    assert html =~ "midwatch"
    assert html =~ "Tatoosh fog signal"
    assert html =~ "yes"
    assert conn.params["id"] == "midwatch"
  end

  defp ticketed_get(conn, path) do
    conn
    |> put_req_header("x-lookout-ticket", "tatoosh-clear")
    |> get(path)
  end
end

defmodule PhoenixMultivitaminWeb.BarraBeachShedTest do
  use PhoenixMultivitaminWeb.ConnCase

  @shed "/features/01-routing-and-plugs/07-barra-beach-shed/shed"

  test "a missing pass halts after check-pass; the turnstile and action never run", %{
    conn: conn
  } do
    conn = get(conn, @shed)
    html = html_response(conn, 403)

    assert html =~ "No beach pass"
    assert html =~ "stamp-beach"
    assert html =~ "check-pass"
    refute html =~ "stamp-turnstile"
    refute html =~ "show-action"
    refute html =~ "Traigh Mhòr 07"
  end

  test "an Islander beach pass lets the turnstile and the action run", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-beach-pass", "islander-beach")
      |> get(@shed)

    html = html_response(conn, 200)

    assert html =~ "walk-on for the Islander"
    assert html =~ "stamp-beach"
    assert html =~ "check-pass"
    assert html =~ "stamp-turnstile"
    assert html =~ "show-action"
    assert html =~ "Traigh Mhòr 07"
  end
end

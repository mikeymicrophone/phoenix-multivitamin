defmodule PhoenixMultivitaminWeb.ColmanDockShedTest do
  use PhoenixMultivitaminWeb.ConnCase

  @shed "/features/01-routing-and-plugs/07-colman-dock-shed/shed"

  test "a missing pass halts after check-pass; the turnstile and action never run", %{
    conn: conn
  } do
    conn = get(conn, @shed)
    html = html_response(conn, 403)

    assert html =~ "No walk-on pass"
    assert html =~ "stamp-dock"
    assert html =~ "check-pass"
    refute html =~ "stamp-turnstile"
    refute html =~ "show-action"
    refute html =~ "Seattle–Bainbridge"
  end

  test "a Wenatchee walk-on pass lets the turnstile and the action run", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-ferry-pass", "wenatchee-walk-on")
      |> get(@shed)

    html = html_response(conn, 200)

    assert html =~ "walk-on for Wenatchee"
    assert html =~ "stamp-dock"
    assert html =~ "check-pass"
    assert html =~ "stamp-turnstile"
    assert html =~ "show-action"
    assert html =~ "Seattle–Bainbridge"
  end
end

defmodule PhoenixMultivitaminWeb.LaPushSkiffLineTest do
  use PhoenixMultivitaminWeb.ConnCase

  @line "/features/01-routing-and-plugs/09-la-push-skiff-line/line"

  test "assigns reach the template; private fields do not until the controller copies them", %{
    conn: conn
  } do
    conn = get(conn, @line)
    html = html_response(conn, 200)

    assert html =~ "Rialto Beach"
    assert html =~ "Three Sisters"
    assert html =~ "Tobin"
    assert html =~ "not on assigns"
    assert html =~ "riptide-west"
    assert html =~ "Quileute Coast Guard"
    refute conn.assigns[:launch_code]
    assert conn.private[:launch_code] == "riptide-west"
  end
end

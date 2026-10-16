defmodule PhoenixMultivitaminWeb.BergenBriefingDeskTest do
  use PhoenixMultivitaminWeb.ConnCase

  @roster "/features/01-routing-and-plugs/11-bergen-briefing-desk/roster"
  @desk "/features/01-routing-and-plugs/11-bergen-briefing-desk/desk"
  @leaky "/features/01-routing-and-plugs/11-bergen-briefing-desk/leaky-desk"

  test "the roster is public", %{conn: conn} do
    conn = get(conn, @roster)
    html = html_response(conn, 200)

    assert html =~ "Sign the roster"
    assert html =~ "Dispatcher Åse"
  end

  test "a missing dispatcher is redirected and halted before the plates open", %{conn: conn} do
    conn = get(conn, @desk)

    assert redirected_to(conn) == @roster
    refute conn.assigns[:plates_opened]
  end

  test "dispatcher Åse in the session reaches the briefing desk", %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{briefing_dispatcher: "Åse"})
      |> get(@desk)

    html = html_response(conn, 200)

    assert html =~ "Åse"
    assert html =~ "Flesland SID plates"
    assert html =~ "yes"
  end

  test "redirect without halt still runs the desk action and raises AlreadySentError", %{
    conn: conn
  } do
    assert_raise Plug.Conn.AlreadySentError, fn ->
      get(conn, @leaky)
    end
  end
end

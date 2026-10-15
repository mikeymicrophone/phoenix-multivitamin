defmodule PhoenixMultivitaminWeb.QuillayuteChartDeskTest do
  use PhoenixMultivitaminWeb.ConnCase

  @roster "/features/01-routing-and-plugs/11-quillayute-chart-desk/roster"
  @desk "/features/01-routing-and-plugs/11-quillayute-chart-desk/desk"
  @leaky "/features/01-routing-and-plugs/11-quillayute-chart-desk/leaky-desk"

  test "the roster is public", %{conn: conn} do
    conn = get(conn, @roster)
    html = html_response(conn, 200)

    assert html =~ "Sign the roster"
    assert html =~ "Officer Wren"
  end

  test "a missing officer is redirected and halted before the charts open", %{conn: conn} do
    conn = get(conn, @desk)

    assert redirected_to(conn) == @roster
    refute conn.assigns[:charts_opened]
  end

  test "officer Wren in the session reaches the chart desk", %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{chart_officer: "Wren"})
      |> get(@desk)

    html = html_response(conn, 200)

    assert html =~ "Wren"
    assert html =~ "La Push bar approaches"
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

defmodule PhoenixMultivitaminWeb.BallardLockHouseTest do
  use PhoenixMultivitaminWeb.ConnCase

  @locks "/features/01-routing-and-plugs/10-ballard-lock-house/locks"

  test "two lockages get a fresh init/1 under test's :runtime plug_init_mode", %{conn: conn} do
    first = get(conn, @locks)
    first_html = html_response(first, 200)

    assert first_html =~ "Hiram M. Chittenden Locks"
    assert first_html =~ "Soren"
    assert first.assigns.chambers == 2

    second = get(conn, @locks)
    _second_html = html_response(second, 200)

    assert first.assigns.plug_compiled_at != second.assigns.plug_compiled_at
    assert first.assigns.plug_called_at != second.assigns.plug_called_at
    assert second.assigns.plug_called_at > first.assigns.plug_called_at
    assert Phoenix.plug_init_mode() == :runtime
  end

  test "init/1 returns a map that already includes compiled_at" do
    opts = PhoenixMultivitaminWeb.BallardLockPlug.init(chambers: 2)

    assert opts.chambers == 2
    assert is_integer(opts.compiled_at)
  end
end

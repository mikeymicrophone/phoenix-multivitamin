defmodule PhoenixMultivitaminWeb.KirunaDeicePadTest do
  use PhoenixMultivitaminWeb.ConnCase

  @pads "/features/01-routing-and-plugs/10-kiruna-deice-pad/pads"

  test "two sprays get a fresh init/1 under test's :runtime plug_init_mode", %{conn: conn} do
    first = get(conn, @pads)
    first_html = html_response(first, 200)

    assert first_html =~ "Kiruna de-ice pad"
    assert first_html =~ "Astrid"
    assert first.assigns.pads == 2

    second = get(conn, @pads)
    _second_html = html_response(second, 200)

    assert first.assigns.plug_compiled_at != second.assigns.plug_compiled_at
    assert first.assigns.plug_called_at != second.assigns.plug_called_at
    assert second.assigns.plug_called_at > first.assigns.plug_called_at
    assert Phoenix.plug_init_mode() == :runtime
  end

  test "init/1 returns a map that already includes compiled_at" do
    opts = PhoenixMultivitaminWeb.KirunaDeicePlug.init(pads: 2)

    assert opts.pads == 2
    assert is_integer(opts.compiled_at)
  end
end

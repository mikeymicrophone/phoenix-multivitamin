# Routing and plugs · 10 · Kiruna de-ice pad
#
# Teaches:
# - init/1 transforms options; call/2 receives that map
# - config :phoenix, :plug_init_mode, :runtime makes init/1 run on every spray in test
# - Production defaults to :compile, so mix test is not proof of compile-time init

defmodule PhoenixMultivitaminWeb.KirunaDeicePadController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug PhoenixMultivitaminWeb.KirunaDeicePlug, pads: 2

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Kiruna de-ice pad")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:apron, "Kiruna iron-ore apron")
    |> render(:show)
  end
end

# Routing and plugs · 10 · Ballard lock house
#
# Teaches:
# - init/1 transforms options; call/2 receives that map
# - config :phoenix, :plug_init_mode, :runtime makes init/1 run on every lockage in test
# - Production defaults to :compile, so mix test is not proof of compile-time init

defmodule PhoenixMultivitaminWeb.BallardLockHouseController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  plug PhoenixMultivitaminWeb.BallardLockPlug, chambers: 2

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Ballard lock house")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:cut, "Lake Washington Ship Canal")
    |> render(:show)
  end
end

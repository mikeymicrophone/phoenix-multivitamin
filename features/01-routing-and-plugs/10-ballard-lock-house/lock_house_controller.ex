# Routing and plugs · 10 · Ballard lock house
#
# Teaches:
# - init/1 runs when the controller compiles; its return value is reused
# - call/2 runs on every request, so called_at moves while compiled_at does not
# - call/2 receives the map from init/1, not the original keyword list

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

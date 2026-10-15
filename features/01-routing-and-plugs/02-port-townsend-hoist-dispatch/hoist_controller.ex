# Routing and plugs · 02 · Port Townsend hoist dispatch
#
# Teaches:
# - A module plug in the router pipeline can halt before the controller action
# - halt/1 skips the dispatcher; missing credentials never reach dispatch/2
# - The same plug assigns yard, hoist, and dispatcher when the ticket is present

defmodule PhoenixMultivitaminWeb.PortTownsendHoistDispatchController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def dispatch(conn, _params) do
    conn
    |> assign(:page_title, "Port Townsend hoist dispatch")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:hull, "troller Marigold")
    |> render(:dispatch)
  end
end

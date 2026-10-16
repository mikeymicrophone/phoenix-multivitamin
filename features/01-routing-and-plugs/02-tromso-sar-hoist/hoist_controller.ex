# Routing and plugs · 02 · Tromsø SAR hoist
#
# Teaches:
# - A module plug in the router pipeline can halt before the controller action
# - halt/1 skips the dispatcher; missing credentials never reach dispatch/2
# - The same plug assigns pad, hoist, and winch operator when the ticket is present

defmodule PhoenixMultivitaminWeb.TromsoSarHoistController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def dispatch(conn, _params) do
    conn
    |> assign(:page_title, "Tromsø SAR hoist")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:craft, "Westland Sea King")
    |> render(:dispatch)
  end
end

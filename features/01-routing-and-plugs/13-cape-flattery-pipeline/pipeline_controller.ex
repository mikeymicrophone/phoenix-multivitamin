# Routing and plugs · 13 · Cape Flattery pipeline
#
# Teaches:
# - Capstone: outer pipeline, forward, halt, nested scopes, and resources
# - The cape plug runs before the forwarded lookout router
# - A missing lookout ticket halts inside the inner router

defmodule PhoenixMultivitaminWeb.CapeFlatteryPipelineController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def cape(conn, _params) do
    conn
    |> assign(:page_title, "Cape Flattery pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:keeper, "Chenoa")
    |> render(:cape)
  end
end

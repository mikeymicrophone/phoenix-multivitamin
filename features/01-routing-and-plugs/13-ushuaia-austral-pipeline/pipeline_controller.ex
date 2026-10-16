# Routing and plugs · 13 · Ushuaia austral pipeline
#
# Teaches:
# - Capstone: outer pipeline, forward, halt, nested scopes, and resources
# - The austral plug runs before the forwarded lookout router
# - A missing lookout ticket halts inside the inner router

defmodule PhoenixMultivitaminWeb.UshuaiaAustralPipelineController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def austral(conn, _params) do
    conn
    |> assign(:page_title, "Ushuaia austral pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:clerk, "Pilar")
    |> render(:austral)
  end
end

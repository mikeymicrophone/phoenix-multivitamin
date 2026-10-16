# Routing and plugs · 06 · Changi hydrant tape
#
# Teaches:
# - A router pipeline plug's assigns are on the conn when the controller renders
# - The same assigns are not already on a LiveView socket; assign_new/3 copies them

defmodule PhoenixMultivitaminWeb.ChangiHydrantTapeController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Changi hydrant tape")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:operator, "Siti")
    |> render(:show)
  end
end

# Routing and plugs · 01 · Lukla shear gate
#
# Teaches:
# - Router pipeline plugs run after the route matches and before the controller
# - Function plugs declared on the controller run next, still before the action
# - Assigns stamped in those plugs are waiting on the conn when show/2 runs

defmodule PhoenixMultivitaminWeb.LuklaShearGateController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  alias PhoenixMultivitaminWeb.LuklaShearPlug

  plug :stamp_shear_window
  plug :stamp_request_meta

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Lukla shear gate")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> render(:show)
  end

  defp stamp_shear_window(conn, _opts) do
    conn
    |> assign(:shear_window, "westerly rotor off Nupla")
    |> assign(:controller_name, "Tashi")
    |> LuklaShearPlug.stamp_trace("shear-window")
  end

  defp stamp_request_meta(conn, _opts) do
    conn
    |> assign(:request_method, conn.method)
    |> LuklaShearPlug.stamp_trace("request-meta")
  end
end

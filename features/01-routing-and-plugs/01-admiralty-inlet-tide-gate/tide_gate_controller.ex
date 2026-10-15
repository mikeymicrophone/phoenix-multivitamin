# Routing and plugs · 01 · Admiralty Inlet tide gate
#
# Teaches:
# - Router pipeline plugs run after the route matches and before the controller
# - Function plugs declared on the controller run next, still before the action
# - Assigns stamped in those plugs are waiting on the conn when show/2 runs

defmodule PhoenixMultivitaminWeb.AdmiraltyInletTideGateController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  alias PhoenixMultivitaminWeb.AdmiraltyInletTidePlug

  plug :stamp_gate_window
  plug :stamp_request_meta

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Admiralty Inlet tide gate")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> render(:show)
  end

  defp stamp_gate_window(conn, _opts) do
    conn
    |> assign(:gate_window, "flood through Partridge Bank")
    |> assign(:keeper, "Maren")
    |> AdmiraltyInletTidePlug.stamp_trace("gate-window")
  end

  defp stamp_request_meta(conn, _opts) do
    conn
    |> assign(:request_method, conn.method)
    |> AdmiraltyInletTidePlug.stamp_trace("request-meta")
  end
end

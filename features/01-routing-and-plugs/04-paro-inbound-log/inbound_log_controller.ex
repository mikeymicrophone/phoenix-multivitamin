# Routing and plugs · 04 · Paro inbound log
#
# Teaches:
# - forward/2 hands a stripped path_info to another Phoenix.Router
# - script_name holds the prefix; request_path still names the full URL
# - The inner router is not aware of /features/.../valley

defmodule PhoenixMultivitaminWeb.ParoInboundLogController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    render_log(conn, %{reg: nil, craft: "Paro inbound A319"})
  end

  def a319(conn, %{"reg" => reg}) do
    render_log(conn, %{reg: reg, craft: craft_name(reg)})
  end

  defp render_log(conn, extra) do
    conn
    |> assign(:page_title, "Paro inbound log")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:reg, extra.reg)
    |> assign(:craft, extra.craft)
    |> render(:show)
  end

  defp craft_name("druk"), do: "Drukair A319"
  defp craft_name(_reg), do: "Paro inbound A319"
end

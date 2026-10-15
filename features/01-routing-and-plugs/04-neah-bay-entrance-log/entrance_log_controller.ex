# Routing and plugs · 04 · Neah Bay entrance log
#
# Teaches:
# - forward/2 hands a stripped path_info to another Phoenix.Router
# - script_name holds the prefix; request_path still names the full URL
# - The inner router is not aware of /features/.../entrance

defmodule PhoenixMultivitaminWeb.NeahBayEntranceLogController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    render_log(conn, %{hull: nil, canoe: "Makah fishing canoe"})
  end

  def canoe(conn, %{"hull" => hull}) do
    render_log(conn, %{hull: hull, canoe: canoe_name(hull)})
  end

  defp render_log(conn, extra) do
    conn
    |> assign(:page_title, "Neah Bay entrance log")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:hull, extra.hull)
    |> assign(:canoe, extra.canoe)
    |> render(:show)
  end

  defp canoe_name("whaler"), do: "Makah whaling canoe"
  defp canoe_name(_hull), do: "Makah fishing canoe"
end

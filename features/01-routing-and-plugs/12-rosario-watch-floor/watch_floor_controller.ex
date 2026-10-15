# Routing and plugs · 12 · Rosario watch floor
#
# Teaches:
# - Nested scopes concatenate path prefixes: /station/:station/watch/:watch/floor
# - Nested pipe_through is additive: the child still runs the parent plugs
# - A sibling scope does not inherit a cousin's pipeline
# - Scope path params arrive as strings

defmodule PhoenixMultivitaminWeb.RosarioWatchFloorController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, %{"station" => station, "watch" => watch}) do
    conn
    |> assign(:page_title, "Rosario watch floor")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, station)
    |> assign(:watch, watch)
    |> assign(:station_is_binary, is_binary(station))
    |> assign(:watch_is_binary, is_binary(watch))
    |> assign(:keeper, keeper_for(station))
    |> assign(:board, "nested")
    |> render(:show)
  end

  def relief(conn, _params) do
    conn
    |> assign(:page_title, "Rosario watch floor")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:station, "relief boat")
    |> assign(:watch, "none")
    |> assign(:station_is_binary, true)
    |> assign(:watch_is_binary, true)
    |> assign(:keeper, "spare lookout")
    |> assign(:strait, conn.assigns[:strait] || "not on this scope")
    |> assign(:board, "relief")
    |> render(:show)
  end

  defp keeper_for("lime-kiln"), do: "Nessa"
  defp keeper_for("cattle-point"), do: "Alden"
  defp keeper_for(_station), do: "the spare lookout"
end

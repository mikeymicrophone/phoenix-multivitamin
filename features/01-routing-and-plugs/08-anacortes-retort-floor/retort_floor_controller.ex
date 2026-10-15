# Routing and plugs · 08 · Anacortes retort floor
#
# Teaches:
# - One controller behind :browser and :api pipelines
# - plug :accepts picks html versus json from the Accept header
# - A mismatched Accept raises 406 and never reaches the cook ledger

defmodule PhoenixMultivitaminWeb.AnacortesRetortFloorController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @cooks %{
    "sockeye-12" => %{kettle: "retort 12", pack: "sockeye halves", minutes: 90},
    "pink-4" => %{kettle: "retort 4", pack: "pink talls", minutes: 75},
    "razor-3" => %{kettle: "retort 3", pack: "razor clams", minutes: 60}
  }

  def index(conn, _params) do
    cooks =
      @cooks
      |> Enum.map(fn {id, cook} -> Map.put(cook, :id, id) end)
      |> Enum.sort_by(& &1.id)

    respond(conn, :index, %{cooks: cooks, cook: nil})
  end

  def show(conn, %{"cook_id" => cook_id}) do
    cook = Map.put(@cooks[cook_id], :id, cook_id)
    respond(conn, :show, %{cooks: [], cook: cook})
  end

  defp respond(conn, template, assigns) do
    case get_format(conn) do
      "json" ->
        json(conn, json_payload(template, assigns))

      _ ->
        conn
        |> assign(:page_title, "Anacortes retort floor")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> assign(:cannery, "Pacific American Cannery")
        |> assign(:floor_boss, "Veda")
        |> assign(:cooks, assigns.cooks)
        |> assign(:cook, assigns.cook)
        |> render(template)
    end
  end

  defp json_payload(:index, %{cooks: cooks}) do
    %{
      cannery: "Pacific American Cannery",
      cooks: Enum.map(cooks, &cook_payload/1)
    }
  end

  defp json_payload(:show, %{cook: cook}) do
    %{cannery: "Pacific American Cannery", cook: cook_payload(cook)}
  end

  defp cook_payload(cook) do
    %{id: cook.id, kettle: cook.kettle, pack: cook.pack, minutes: cook.minutes}
  end
end

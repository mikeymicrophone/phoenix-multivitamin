defmodule PhoenixMultivitaminWeb.CapeFlatteryWatchController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @watches %{
    "nessa" => [
      %{id: "evening", window: "20:00–00:00", glass: "Cape Flattery light"},
      %{id: "midwatch", window: "00:00–04:00", glass: "Tatoosh fog signal"}
    ],
    "corin" => [
      %{id: "morning", window: "04:00–08:00", glass: "Duncan Rock"}
    ]
  }

  def index(conn, %{"keeper" => keeper}) do
    conn
    |> assign(:page_title, "Cape Flattery pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:keeper, keeper)
    |> assign(:keeper_is_binary, is_binary(keeper))
    |> assign(:watches, Map.fetch!(@watches, keeper))
    |> render(:index)
  end

  def show(conn, %{"keeper" => keeper, "id" => id}) do
    watch = Enum.find(Map.fetch!(@watches, keeper), &(&1.id == id))

    conn
    |> assign(:page_title, "Cape Flattery pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:keeper, keeper)
    |> assign(:watch, watch)
    |> assign(:watch_id, id)
    |> assign(:watch_id_is_binary, is_binary(id))
    |> render(:show)
  end
end

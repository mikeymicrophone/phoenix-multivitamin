defmodule PhoenixMultivitaminWeb.UshuaiaWatchController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @watches %{
    "pilar" => [
      %{id: "evening", window: "20:00–00:00", glass: "Ushuaia runway 07"},
      %{id: "midwatch", window: "00:00–04:00", glass: "Martial ice light"}
    ],
    "mateo" => [
      %{id: "morning", window: "04:00–08:00", glass: "Olivia basin"}
    ]
  }

  def index(conn, %{"clerk" => clerk}) do
    conn
    |> assign(:page_title, "Ushuaia austral pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:clerk, clerk)
    |> assign(:clerk_is_binary, is_binary(clerk))
    |> assign(:watches, Map.fetch!(@watches, clerk))
    |> render(:index)
  end

  def show(conn, %{"clerk" => clerk, "id" => id}) do
    watch = Enum.find(Map.fetch!(@watches, clerk), &(&1.id == id))

    conn
    |> assign(:page_title, "Ushuaia austral pipeline")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:clerk, clerk)
    |> assign(:watch, watch)
    |> assign(:watch_id, id)
    |> assign(:watch_id_is_binary, is_binary(id))
    |> render(:show)
  end
end

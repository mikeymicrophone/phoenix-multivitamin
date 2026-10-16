# Controllers and JSON · 13 · Punta Arenas austral load
#
# Teaches:
# - Capstone: JSON index, HTML show, create with json/2, fallback on changeset
# - The same controller owns all four doors

defmodule PhoenixMultivitaminWeb.PuntaArenasAustralLoadController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  action_fallback PhoenixMultivitaminWeb.PuntaArenasLoadFallback

  @loads %{
    "teniente" => %{
      id: "teniente",
      loadmaster: "Cristóbal",
      craft: "Lockheed C-130",
      destination: "Teniente Marsh",
      cargo: "fuel bladders",
      kg: 9_600
    },
    "rothera" => %{
      id: "rothera",
      loadmaster: "Cristóbal",
      craft: "Lockheed C-130",
      destination: "Rothera",
      cargo: "science crates",
      kg: 7_200
    }
  }

  def index(conn, _params) do
    loads =
      @loads
      |> Map.values()
      |> Enum.sort_by(& &1.id)

    json(conn, %{station: "SCCI", loads: loads})
  end

  def show(conn, %{"id" => id}) do
    case Map.fetch(@loads, id) do
      {:ok, load} ->
        conn
        |> assign(:page_title, "Punta Arenas austral load")
        |> assign(:flash, conn.assigns[:flash] || %{})
        |> assign(:load, load)
        |> render(:show)

      :error ->
        {:error, :not_found}
    end
  end

  def create(conn, %{"load" => params}) do
    case accept_load(params) do
      {:ok, load} ->
        conn
        |> put_status(:created)
        |> json(%{load: load})

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp accept_load(params) do
    types = %{destination: :string, cargo: :string}

    {%{}, types}
    |> Ecto.Changeset.cast(params, [:destination, :cargo])
    |> Ecto.Changeset.validate_required([:destination, :cargo])
    |> Ecto.Changeset.validate_length(:destination, min: 6)
    |> unwrap_load()
  end

  defp unwrap_load(%Ecto.Changeset{valid?: true} = changeset) do
    {:ok,
     changeset.changes
     |> Map.put(:loadmaster, "Cristóbal")
     |> Map.put(:craft, "Lockheed C-130")}
  end

  defp unwrap_load(changeset), do: {:error, changeset}
end

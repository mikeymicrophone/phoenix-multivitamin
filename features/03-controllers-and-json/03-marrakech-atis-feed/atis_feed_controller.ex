# Controllers and JSON · 03 · Marrakech ATIS feed
#
# Teaches:
# - action_fallback/1 receives {:error, changeset} from the action
# - A valid create still returns the conn itself; only the error tuple is delegated

defmodule PhoenixMultivitaminWeb.MarrakechAtisFeedController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  action_fallback PhoenixMultivitaminWeb.MarrakechAtisFallback

  @current %{
    station: "GMMX",
    clerk: "Youssef",
    info: "BRAVO",
    wind: "24012KT",
    runway: "10"
  }

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Marrakech ATIS feed")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:atis, @current)
    |> render(:show)
  end

  def create(conn, %{"atis" => params}) do
    case post_atis(params) do
      {:ok, atis} ->
        conn
        |> put_status(:created)
        |> json(%{atis: atis})

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp post_atis(params) do
    types = %{info: :string, wind: :string}

    {%{}, types}
    |> Ecto.Changeset.cast(params, [:info, :wind])
    |> Ecto.Changeset.validate_required([:info, :wind])
    |> Ecto.Changeset.validate_length(:info, min: 8)
    |> unwrap_atis()
  end

  defp unwrap_atis(%Ecto.Changeset{valid?: true} = changeset) do
    {:ok,
     changeset.changes
     |> Map.put(:station, "GMMX")
     |> Map.put(:clerk, "Youssef")}
  end

  defp unwrap_atis(changeset), do: {:error, changeset}
end

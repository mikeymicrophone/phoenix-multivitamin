# Controllers and JSON · 10 · Leh density-altitude card
#
# Teaches:
# - create/2 pattern-matches params nested under "card"
# - A flat param map does not match that clause
# - The nested oat and elevation_ft are the values the action reads
# - with validates complete Integer.parse results before calculating

defmodule PhoenixMultivitaminWeb.LehDensityAltitudeCardController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def show(conn, _params) do
    conn
    |> assign(:page_title, "Leh density-altitude card")
    |> assign(:flash, conn.assigns[:flash] || %{})
    |> assign(:engineer, "Tenzin")
    |> assign(:craft, "Antonov An-32")
    |> assign(:card, nil)
    |> render(:show)
  end

  def create(conn, %{"card" => %{"oat_c" => oat, "elevation_ft" => elevation}}) do
    with {oat_c, ""} <- parse_reading(oat),
         {elevation_ft, ""} <- parse_reading(elevation) do
      card = %{
        engineer: "Tenzin",
        craft: "Antonov An-32",
        oat_c: oat,
        elevation_ft: elevation,
        density_altitude_ft: elevation_ft + trunc((oat_c - 15) * 120)
      }

      conn
      |> put_status(:created)
      |> json(%{card: card, nested: true})
    else
      _invalid_reading ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "card_reading_invalid", nested: true})
    end
  end

  def create(conn, _params) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{error: "card_missing", nested: false})
  end

  defp parse_reading(reading) when is_binary(reading), do: Integer.parse(reading)
  defp parse_reading(_reading), do: :error
end

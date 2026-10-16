# Controllers and JSON · 09 · Malé atoll slot list
#
# Teaches:
# - A missing record is put_status(:not_found) then json/2
# - The body is an error map, not ErrorHTML's "Not Found" text page

defmodule PhoenixMultivitaminWeb.MaleAtollSlotListController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  @slots %{
    "hulhule-14" => %{
      id: "hulhule-14",
      clerk: "Mariyam",
      craft: "Airbus A321",
      stand: "14",
      island: "Hulhulé",
      minutes: 45
    }
  }

  def show(conn, %{"id" => id}) do
    case Map.fetch(@slots, id) do
      {:ok, slot} ->
        json(conn, %{slot: slot})

      :error ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "slot_missing", id: id, station: "VRMM"})
    end
  end
end

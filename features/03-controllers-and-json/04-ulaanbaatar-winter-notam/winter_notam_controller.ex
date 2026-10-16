# Controllers and JSON · 04 · Ulaanbaatar winter NOTAM
#
# Teaches:
# - action_fallback/1 handles {:error, :not_found} from the action
# - A rescued ArgumentError is answered in the action; fallback is not called
# - Returning a conn short-circuits the fallback even when the status is 422

defmodule PhoenixMultivitaminWeb.UlaanbaatarWinterNotamController do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  action_fallback PhoenixMultivitaminWeb.UlaanbaatarNotamFallback

  @notams %{
    "ubbn-ice" => %{
      series: "A0123/26",
      station: "ZMCK",
      clerk: "Oyuna",
      craft: "Fokker 100",
      text: "RWY 14/32 ice patches, braking action poor"
    }
  }

  def show(conn, %{"notam" => notam}) do
    case Map.fetch(@notams, notam) do
      {:ok, entry} -> json(conn, %{notam: entry, via: "action"})
      :error -> {:error, :not_found}
    end
  end

  def explode(conn, _params) do
    _ = String.to_integer("runway-Q")
    json(conn, %{ok: true})
  rescue
    error in ArgumentError ->
      conn
      |> put_status(:unprocessable_entity)
      |> json(%{error: Exception.message(error), via: "rescue"})
  end
end

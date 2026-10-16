# Controllers and JSON · 04 · Ulaanbaatar winter NOTAM
#
# Teaches:
# - call/2 for {:error, :not_found} is a JSON 404 with via: "fallback"

defmodule PhoenixMultivitaminWeb.UlaanbaatarNotamFallback do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "notam_missing", via: "fallback"})
  end
end

# Controllers and JSON · 03 · Marrakech ATIS feed
#
# Teaches:
# - A fallback controller's call/2 is the error body
# - Changeset errors become a JSON map, not an HTML 500

defmodule PhoenixMultivitaminWeb.MarrakechAtisFallback do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{
      error: "invalid_atis",
      errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)
    })
  end
end

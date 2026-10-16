# Controllers and JSON · 13 · Punta Arenas austral load
#
# Teaches:
# - One fallback handles {:error, :not_found} and {:error, changeset}

defmodule PhoenixMultivitaminWeb.PuntaArenasLoadFallback do
  @moduledoc false
  use PhoenixMultivitaminWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "load_missing", via: "fallback"})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{
      error: "invalid_load",
      via: "fallback",
      errors: Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)
    })
  end
end

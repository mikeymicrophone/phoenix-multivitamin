defmodule PhoenixMultivitaminWeb.UshuaiaAustralPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:austral, "Ushuaia austral")
    |> assign(:nation, "Tierra del Fuego")
    |> stamp_trace("austral")
  end

  def stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end

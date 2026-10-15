defmodule PhoenixMultivitaminWeb.CapeFlatteryCapePlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:cape, "Cape Flattery")
    |> assign(:nation, "Makah")
    |> stamp_trace("cape")
  end

  def stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end

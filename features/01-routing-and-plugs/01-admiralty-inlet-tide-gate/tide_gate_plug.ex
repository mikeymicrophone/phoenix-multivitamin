defmodule PhoenixMultivitaminWeb.AdmiraltyInletTidePlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:inlet, "Admiralty Inlet")
    |> assign(:gate, "Point Wilson tide gate")
    |> stamp_trace("inlet-pipeline")
  end

  def stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end

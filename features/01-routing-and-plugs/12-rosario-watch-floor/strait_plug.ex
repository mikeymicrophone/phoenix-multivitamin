defmodule PhoenixMultivitaminWeb.RosarioStraitPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:strait, "Rosario Strait")
    |> stamp_trace("strait")
  end

  def stamp_trace(conn, step) do
    assign(conn, :pipeline_trace, (conn.assigns[:pipeline_trace] || []) ++ [step])
  end
end

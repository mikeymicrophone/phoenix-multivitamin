defmodule PhoenixMultivitaminWeb.ParoInboundPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:station, "Paro valley")
    |> assign(:clerk, "Kinley")
    |> assign(:request_path, conn.request_path)
    |> assign(:script_name, Enum.join(conn.script_name, "/"))
    |> assign(:path_info, Enum.join(conn.path_info, "/"))
  end
end

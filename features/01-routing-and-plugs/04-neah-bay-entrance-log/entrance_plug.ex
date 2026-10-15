defmodule PhoenixMultivitaminWeb.NeahBayEntrancePlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:station, "Neah Bay entrance")
    |> assign(:recorder, "Chenoa")
    |> assign(:request_path, conn.request_path)
    |> assign(:script_name, Enum.join(conn.script_name, "/"))
    |> assign(:path_info, Enum.join(conn.path_info, "/"))
  end
end

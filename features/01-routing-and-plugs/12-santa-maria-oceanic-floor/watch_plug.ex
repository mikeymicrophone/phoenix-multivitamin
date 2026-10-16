defmodule PhoenixMultivitaminWeb.SantaMariaWatchPlug do
  @moduledoc false
  import Plug.Conn

  alias PhoenixMultivitaminWeb.SantaMariaOceanicPlug

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:watch_plug, "watch floor")
    |> SantaMariaOceanicPlug.stamp_trace("watch")
  end
end

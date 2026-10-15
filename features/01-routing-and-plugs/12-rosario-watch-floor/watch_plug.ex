defmodule PhoenixMultivitaminWeb.RosarioWatchPlug do
  @moduledoc false
  import Plug.Conn

  alias PhoenixMultivitaminWeb.RosarioStraitPlug

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:watch_plug, "watch floor")
    |> RosarioStraitPlug.stamp_trace("watch")
  end
end

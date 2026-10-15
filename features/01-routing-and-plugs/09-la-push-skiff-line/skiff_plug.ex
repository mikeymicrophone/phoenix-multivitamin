defmodule PhoenixMultivitaminWeb.LaPushSkiffPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:beach, "Rialto Beach")
    |> assign(:skiff, "Quileute surf skiff Three Sisters")
    |> assign(:skipper, "Tobin")
    |> put_private(:launch_code, "riptide-west")
    |> put_private(:radio_channel, "Quileute Coast Guard")
  end
end

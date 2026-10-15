defmodule PhoenixMultivitaminWeb.FridayHarborInspectorPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    lane = Keyword.fetch!(opts, :lane)

    conn
    |> assign(:lane, lane)
    |> assign(:shed, "Friday Harbor customs shed")
    |> assign(:inspector, "Ellis")
  end
end

defmodule PhoenixMultivitaminWeb.WillapaSeedBargePlug do
  @moduledoc false
  import Plug.Conn

  def init(opts) do
    %{
      landing: Keyword.fetch!(opts, :landing),
      crop: Keyword.fetch!(opts, :crop),
      barge: Keyword.fetch!(opts, :barge)
    }
  end

  def call(conn, %{landing: landing, crop: crop, barge: barge}) do
    conn
    |> assign(:landing, landing)
    |> assign(:crop, crop)
    |> assign(:barge, barge)
    |> assign(:clerk, "Nadine")
    |> assign(:init_keys, "landing crop barge")
  end
end

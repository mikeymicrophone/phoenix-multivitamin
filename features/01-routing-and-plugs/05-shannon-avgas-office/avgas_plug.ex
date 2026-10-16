defmodule PhoenixMultivitaminWeb.ShannonAvgasPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts) do
    %{
      apron: Keyword.fetch!(opts, :apron),
      grade: Keyword.fetch!(opts, :grade),
      bowser: Keyword.fetch!(opts, :bowser)
    }
  end

  def call(conn, %{apron: apron, grade: grade, bowser: bowser}) do
    conn
    |> assign(:apron, apron)
    |> assign(:grade, grade)
    |> assign(:bowser, bowser)
    |> assign(:clerk, "Orla")
    |> assign(:init_keys, "apron grade bowser")
  end
end

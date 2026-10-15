defmodule PhoenixMultivitaminWeb.BallardLockPlug do
  @moduledoc false
  import Plug.Conn

  def init(opts) do
    %{
      chambers: Keyword.fetch!(opts, :chambers),
      compiled_at: System.unique_integer([:monotonic])
    }
  end

  def call(conn, %{chambers: chambers, compiled_at: compiled_at}) do
    conn
    |> assign(:chambers, chambers)
    |> assign(:plug_compiled_at, compiled_at)
    |> assign(:plug_called_at, System.unique_integer([:monotonic]))
    |> assign(:lock, "Hiram M. Chittenden Locks")
    |> assign(:keeper, "Soren")
  end
end

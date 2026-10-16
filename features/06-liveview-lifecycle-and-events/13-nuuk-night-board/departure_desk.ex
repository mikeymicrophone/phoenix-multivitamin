defmodule PhoenixMultivitaminWeb.NuukDepartureDesk do
  @moduledoc false
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def record(departure) do
    if Process.whereis(__MODULE__) do
      Agent.update(__MODULE__, &[departure | &1])
    end
  end

  def departures do
    case Process.whereis(__MODULE__) do
      nil -> []
      _pid -> Agent.get(__MODULE__, & &1)
    end
  end
end

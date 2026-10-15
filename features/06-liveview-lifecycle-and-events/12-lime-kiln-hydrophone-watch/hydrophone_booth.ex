defmodule PhoenixMultivitaminWeb.LimeKilnHydrophoneBooth do
  @moduledoc false
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{dons: 0, last_hook: nil} end, name: __MODULE__)
  end

  def record_don do
    if Process.whereis(__MODULE__) do
      Agent.update(__MODULE__, fn state ->
        Map.update!(state, :dons, &(&1 + 1))
      end)
    end
  end

  def don_count do
    case Process.whereis(__MODULE__) do
      nil -> 0
      _pid -> Agent.get(__MODULE__, & &1.dons)
    end
  end

  def record_hook(event) do
    if Process.whereis(__MODULE__) do
      Agent.update(__MODULE__, &Map.put(&1, :last_hook, event))
    end
  end

  def last_hook do
    case Process.whereis(__MODULE__) do
      nil -> nil
      _pid -> Agent.get(__MODULE__, & &1.last_hook)
    end
  end
end

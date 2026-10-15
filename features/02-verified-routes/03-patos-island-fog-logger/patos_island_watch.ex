defmodule PhoenixMultivitaminWeb.PatosIslandWatch do
  @moduledoc false
  @derive {Phoenix.Param, key: :slug}
  defstruct [:slug, :keeper, :window, :horn]
end

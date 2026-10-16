# Async assigns · 09 · Kangerlussuaq sounding
#
# Teaches:
# - The schema lives with the scenario
# - Repo reads go through this table

defmodule PhoenixMultivitamin.KangerlussuaqSounding do
  @moduledoc false
  use Ecto.Schema

  schema "kangerlussuaq_soundings" do
    field :clerk, :string
    field :craft, :string
    field :oat_c, :integer
    timestamps(type: :utc_datetime)
  end
end

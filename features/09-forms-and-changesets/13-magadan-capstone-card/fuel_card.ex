# Forms and changesets · 13 · Magadan fuel card
#
# Teaches:
# - The schema lives with the scenario
# - Repo writes go through this table

defmodule PhoenixMultivitamin.MagadanFuelCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixMultivitamin.MagadanPayload

  schema "magadan_fuel_cards" do
    field :clerk, :string
    field :craft, :string
    field :litres, :integer
    embeds_one :payload, MagadanPayload, on_replace: :update
    timestamps(type: :utc_datetime)
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :litres])
    |> validate_required([:clerk, :craft, :litres])
    |> validate_number(:litres, greater_than: 0)
    |> cast_embed(:payload, required: true)
  end
end

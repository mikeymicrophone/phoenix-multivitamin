# Forms and changesets · 02 · Gwadar cargo card
#
# Teaches:
# - validate_number rejects a pallet over the An-12 floor

defmodule PhoenixMultivitamin.GwadarCargoCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :pallet_kg, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :pallet_kg])
    |> validate_required([:clerk, :craft, :pallet_kg])
    |> validate_number(:pallet_kg, less_than_or_equal_to: 8_000)
  end
end

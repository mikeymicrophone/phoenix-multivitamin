# Forms and changesets · 09 · Kashgar endurance card
#
# Teaches:
# - Empty strings cast to nil on an integer field

defmodule PhoenixMultivitamin.KashgarEnduranceCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :endurance_min, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :endurance_min])
    |> validate_required([:clerk, :craft])
  end
end

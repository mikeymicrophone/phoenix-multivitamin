# Forms and changesets · 11 · Kuujjuaq ice card
#
# Teaches:
# - The submit stays off until the changeset is valid

defmodule PhoenixMultivitamin.KuujjuaqIceCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :ice_mm, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :ice_mm])
    |> validate_required([:clerk, :craft, :ice_mm])
    |> validate_number(:ice_mm, greater_than: 0, less_than_or_equal_to: 25)
  end
end

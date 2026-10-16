# Forms and changesets · 12 · Aitutaki lagoon card
#
# Teaches:
# - A successful save can replace the form with a fresh changeset

defmodule PhoenixMultivitamin.AitutakiLagoonCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :passengers, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :passengers])
    |> validate_required([:clerk, :craft, :passengers])
    |> validate_number(:passengers, greater_than: 0, less_than_or_equal_to: 15)
  end
end

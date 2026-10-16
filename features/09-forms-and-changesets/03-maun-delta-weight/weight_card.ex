# Forms and changesets · 03 · Maun delta weight card
#
# Teaches:
# - A valid card is the only one that may be posted

defmodule PhoenixMultivitamin.MaunWeightCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :souls, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :souls])
    |> validate_required([:clerk, :craft, :souls])
    |> validate_number(:souls, greater_than: 0, less_than_or_equal_to: 8)
  end
end

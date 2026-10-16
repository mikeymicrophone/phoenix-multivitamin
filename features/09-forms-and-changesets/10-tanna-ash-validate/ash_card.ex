# Forms and changesets · 10 · Tanna ash card
#
# Teaches:
# - :validate and :insert are different changeset actions

defmodule PhoenixMultivitamin.TannaAshCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :ash_ft, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :ash_ft])
    |> validate_required([:clerk, :craft, :ash_ft])
    |> validate_number(:ash_ft, greater_than: 0)
  end
end

# Forms and changesets · 07 · Ivalo deice card
#
# Teaches:
# - Recovered params are an ordinary changeset

defmodule PhoenixMultivitamin.IvaloDeiceCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :fluid, :string
    field :tank_c, :integer
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft, :fluid, :tank_c])
    |> validate_required([:clerk, :craft, :fluid, :tank_c])
    |> validate_inclusion(:fluid, ["Type I", "Type IV"])
  end
end

# Forms and changesets · 13 · Magadan payload
#
# Teaches:
# - Nested payload fields validate with the parent card

defmodule PhoenixMultivitamin.MagadanPayload do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :cargo_kg, :integer
    field :souls, :integer
  end

  def changeset(payload, attrs) do
    payload
    |> cast(attrs, [:cargo_kg, :souls])
    |> validate_required([:cargo_kg, :souls])
    |> validate_number(:cargo_kg, greater_than: 0)
    |> validate_number(:souls, greater_than: 0)
  end
end

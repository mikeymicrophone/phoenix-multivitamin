# Forms and changesets · 08 · Dili CN slip
#
# Teaches:
# - The same changeset feeds a controller form

defmodule PhoenixMultivitamin.DiliCnSlip do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :destination, :string
  end

  def changeset(slip, attrs) do
    slip
    |> cast(attrs, [:clerk, :craft, :destination])
    |> validate_required([:clerk, :craft, :destination])
    |> validate_length(:destination, min: 3)
  end
end

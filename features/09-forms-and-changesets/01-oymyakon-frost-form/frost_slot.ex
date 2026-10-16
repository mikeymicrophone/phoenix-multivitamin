# Forms and changesets · 01 · Oymyakon frost slot
#
# Teaches:
# - An embedded schema is enough for to_form/1

defmodule PhoenixMultivitamin.OymyakonFrostSlot do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :delay_min, :integer
  end

  def changeset(slot, attrs) do
    slot
    |> cast(attrs, [:clerk, :craft, :delay_min])
    |> validate_required([:clerk, :craft, :delay_min])
    |> validate_number(:delay_min, greater_than: 0)
  end
end

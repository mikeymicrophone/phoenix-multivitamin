# Forms and changesets · 04 · Skardu fuel slip
#
# Teaches:
# - Field errors sit next to the litres input

defmodule PhoenixMultivitamin.SkarduFuelSlip do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :litres, :integer
  end

  def changeset(slip, attrs) do
    slip
    |> cast(attrs, [:clerk, :craft, :litres])
    |> validate_required([:clerk, :craft, :litres])
    |> validate_number(:litres, greater_than: 0, less_than_or_equal_to: 2_700)
  end
end

# Forms and changesets · 05 · Hiva Oa tow
#
# Teaches:
# - The nested embed is its own schema

defmodule PhoenixMultivitamin.HivaOaTow do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :rope_m, :integer
    field :pilot, :string
  end

  def changeset(tow, attrs) do
    tow
    |> cast(attrs, [:rope_m, :pilot])
    |> validate_required([:rope_m, :pilot])
    |> validate_number(:rope_m, greater_than: 0)
  end
end

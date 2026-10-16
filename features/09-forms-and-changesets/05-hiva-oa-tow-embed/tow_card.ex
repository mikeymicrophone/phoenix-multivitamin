# Forms and changesets · 05 · Hiva Oa tow card
#
# Teaches:
# - cast_embed pulls the nested tow onto the parent

defmodule PhoenixMultivitamin.HivaOaTowCard do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixMultivitamin.HivaOaTow

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    embeds_one :tow, HivaOaTow, on_replace: :update
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:clerk, :craft])
    |> validate_required([:clerk, :craft])
    |> cast_embed(:tow, required: true)
  end
end

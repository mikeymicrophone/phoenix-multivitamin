# Forms and changesets · 06 · Khasab fjord manifest
#
# Teaches:
# - select, checkbox, and textarea are ordinary changeset fields

defmodule PhoenixMultivitamin.KhasabFjordManifest do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :clerk, :string
    field :craft, :string
    field :fjord, :string
    field :night_vision, :boolean, default: false
    field :remarks, :string
  end

  def changeset(manifest, attrs) do
    manifest
    |> cast(attrs, [:clerk, :craft, :fjord, :night_vision, :remarks])
    |> validate_required([:clerk, :craft, :fjord, :remarks])
    |> validate_inclusion(:fjord, ["Khasab creek", "Kumzar", "Musandam tip"])
  end
end

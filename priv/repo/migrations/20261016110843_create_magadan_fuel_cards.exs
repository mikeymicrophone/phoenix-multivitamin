defmodule PhoenixMultivitamin.Repo.Migrations.CreateMagadanFuelCards do
  use Ecto.Migration

  def change do
    create table(:magadan_fuel_cards) do
      add :clerk, :string, null: false
      add :craft, :string, null: false
      add :litres, :integer, null: false
      add :payload, :map, null: false

      timestamps(type: :utc_datetime)
    end
  end
end

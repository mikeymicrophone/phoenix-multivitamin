defmodule PhoenixMultivitamin.Repo.Migrations.CreateKangerlussuaqSoundings do
  use Ecto.Migration

  def change do
    create table(:kangerlussuaq_soundings) do
      add :clerk, :string, null: false
      add :craft, :string, null: false
      add :oat_c, :integer, null: false

      timestamps(type: :utc_datetime)
    end
  end
end

defmodule Foodies.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string, null: false
      add :description, :text
      add :lat, :float, null: false
      add :lng, :float, null: false
      add :ratio, :float, null: false

      timestamps()
    end

    create unique_index(:locations, [:lat, :lng])
  end
end

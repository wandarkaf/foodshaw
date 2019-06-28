defmodule Foodies.Repo.Migrations.CreateIngredientsLocations do
  use Ecto.Migration

  def change do
    create table(:ingredients_locations, primary_key: false) do
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), primary_key: true
      add :location_id, references(:locations, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:ingredients_locations, [:ingredient_id, :location_id])
    create_if_not_exists unique_index(:ingredients_locations, [:ingredient_id, :location_id])
  end
end
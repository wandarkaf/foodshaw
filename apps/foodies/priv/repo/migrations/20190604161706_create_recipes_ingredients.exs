defmodule Foodies.Repo.Migrations.CreateRecipesIngredients do
  use Ecto.Migration

  def change do
    create table(:recipes_ingredients, primary_key: false) do
      add :recipe_id, references(:recipes, on_delete: :delete_all), primary_key: true
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), primary_key: true
      add :quantity, :decimal, null: false

      timestamps()
    end

    create index(:recipes_ingredients, [:recipe_id, :ingredient_id])
    create_if_not_exists unique_index(:recipes_ingredients, [:recipe_id, :ingredient_id])
  end
end

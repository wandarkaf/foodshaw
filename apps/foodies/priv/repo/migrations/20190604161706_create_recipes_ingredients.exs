defmodule Foodies.Repo.Migrations.CreateRecipesIngredients do
  use Ecto.Migration

  def change do
    create table(:recipes_ingredients) do
      add :recipe_id, references(:recipes, on_delete: :delete_all), null: false
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), null: false
      add :quantity, :float, null: false

      timestamps()
    end

    create(index(:recipes_ingredients, [:recipe_id, :ingredient_id]))
  end
end

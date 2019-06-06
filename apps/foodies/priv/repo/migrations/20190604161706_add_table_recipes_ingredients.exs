defmodule Foodies.Repo.Migrations.AddTableRecipesIngredients do
  use Ecto.Migration

  def change do
    create table(:recipes_ingredients) do
      add :recipe_id, references(:recipes)
      add :ingredient_id, references(:ingredients)
      add :quantity, :integer

      timestamps()
    end

    create(index(:recipes_ingredients, [:recipe_id]))
    create(index(:recipes_ingredients, [:ingredient_id]))
  end
end

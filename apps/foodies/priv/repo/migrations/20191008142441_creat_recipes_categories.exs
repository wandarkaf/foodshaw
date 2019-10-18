defmodule Foodies.Repo.Migrations.CreatRecipesCategories do
  use Ecto.Migration

  def change do
    create table(:recipes_categories, primary_key: false) do
      # add :recipe_id, references(:recipes, on_delete: :delete_all), primary_key: true
      # add :category_id, references(:categories, on_delete: :delete_all), primary_key: true

      # timestamps()

      add :recipe_id, references(:recipes)
      add :category_id, references(:categories)
    end

    # create index(:recipes_categories, [:recipe_id, :category_id])
    # create_if_not_exists unique_index(:recipes_categories, [:recipe_id, :category_id])
  end
end

defmodule Foodies.Repo.Migrations.AlterRecipesIngredients do
  use Ecto.Migration

  def change do
    alter table(:recipes_ingredients) do
      add :measure_id, references(:measures, on_delete: :delete_all), null: false
    end

    create(index(:recipes_ingredients, [:measure_id]))
  end
end

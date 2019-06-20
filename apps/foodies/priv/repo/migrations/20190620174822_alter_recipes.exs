defmodule Foodies.Repo.Migrations.AlterRecipes do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :category_id, references(:categories)
    end
  end
end

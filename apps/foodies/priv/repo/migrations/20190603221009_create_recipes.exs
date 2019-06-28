defmodule Foodies.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :source_url, :string, null: false
      add :servings, :integer, null: false
      add :img_cover_url, :string
      add :spicy, :integer, default: 0

      timestamps()
    end

    create unique_index(:recipes, [:name])
  end
end

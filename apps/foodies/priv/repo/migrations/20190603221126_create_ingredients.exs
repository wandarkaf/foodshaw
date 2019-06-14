defmodule Foodies.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :img_cover_url, :string

      timestamps()
    end

    create unique_index(:ingredients, [:name])
  end
end

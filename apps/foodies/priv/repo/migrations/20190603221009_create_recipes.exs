defmodule Foodies.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end

defmodule Foodies.Repo.Migrations.CreateInstructions do
  use Ecto.Migration

  def change do
    create table(:instructions) do
      add :preparation, :text, null: false
      add :time, :decimal, default: 0
      add :recipe_id, references(:recipes, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:instructions, [:recipe_id])
  end
end

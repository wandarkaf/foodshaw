defmodule Foodies.Repo.Migrations.CreateMeasures do
  use Ecto.Migration

  def change do
    create table(:measures) do
      add :type, :string, null: false
      add :abbreviaton, :string, null: false
      add :description, :text, null: false
      add :img_cover_url, :string
      add :weight, :decimal, null: false

      timestamps()
    end

    create unique_index(:measures, [:type, :abbreviaton])
  end
end

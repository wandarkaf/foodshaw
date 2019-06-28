defmodule Foodies.Repo.Migrations.CreateUsers do
  # FOODSHAW
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end

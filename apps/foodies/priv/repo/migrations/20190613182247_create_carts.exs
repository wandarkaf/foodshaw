defmodule Foodies.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :reset, :integer, default: 0
      add :share, {:array, :string}

      timestamps()
    end

    create unique_index(:carts, [:name])
    create index(:carts, [:user_id])
  end
end

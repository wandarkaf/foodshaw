defmodule Foodies.Repo.Migrations.CreateCartsIngredients do
  use Ecto.Migration

  def change do
    create table(:carts_ingredients, primary_key: false) do
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), primary_key: true
      add :cart_id, references(:carts, on_delete: :delete_all), primary_key: true
      add :checked, :boolean, default: false, null: false
      add :quantity, :decimal, null: false

      timestamps()
    end

    create index(:carts_ingredients, [:ingredient_id, :cart_id])
    create_if_not_exists unique_index(:carts_ingredients, [:ingredient_id, :cart_id])
  end
end

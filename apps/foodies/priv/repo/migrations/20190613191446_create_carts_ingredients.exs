defmodule Foodies.Repo.Migrations.CreateCartsIngredients do
  use Ecto.Migration

  def change do
    create table(:carts_ingredients) do
      add :ingredient_id, references(:ingredients, on_delete: :delete_all), null: false
      add :cart_id, references(:carts, on_delete: :delete_all), null: false
      add :checked, :boolean, default: false, null: false

      timestamps()
    end

    create(index(:carts_ingredients, [:ingredient_id]))
  end
end

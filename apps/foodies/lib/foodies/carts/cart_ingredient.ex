defmodule Foodies.Carts.CartIngredient do
  use Ecto.Schema

  @primary_key false
  schema "carts_ingredients" do
    belongs_to :cart, Foodies.Carts.Cart, primary_key: true
    belongs_to :ingredient, Foodies.Ingredients.Ingredient, primary_key: true

    field :checked, :boolean
    field :quantity, :decimal

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:cart_id, :ingredient_id, :checked, :quantity])
    |> Ecto.Changeset.validate_required([:cart_id, :ingredient_id, :checked, :quantity])
  end
end

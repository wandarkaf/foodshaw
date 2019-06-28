defmodule Foodies.Ingredients.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Repo
  alias Foodies.Ingredients.{Location, IngredientLocation}
  alias Foodies.Recipes.RecipeIngredient
  alias Foodies.Carts.CartIngredient

  schema "ingredients" do
    field :description, :string
    field :name, :string
    field :img_cover_url, :string

    has_many :recipes_ingredients, RecipeIngredient
    has_many :carts_ingredients, CartIngredient

    many_to_many(
      :locations,
      Location,
      join_through: IngredientLocation,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :description, :img_cover_url])
    # |> cast_assoc(:recipes_ingredients)
    |> validate_required([:name, :description])
  end

  def changeset_update_locations(ingredient, locations) do
    ingredient
    |> Repo.preload(:locations)
    |> change()
    |> put_assoc(:locations, locations)
  end
end

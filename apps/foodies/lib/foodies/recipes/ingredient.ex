defmodule Foodies.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Recipes.{Recipe, RecipeIngredient}

  schema "ingredients" do
    field :description, :string
    field :name, :string
    field :img_cover_url, :string

    # many_to_many :recipes, Recipe, join_through: RecipeIngredient
    has_many :recipes_ingredients, RecipeIngredient

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :description, :img_cover_url])
    # |> cast_assoc(:recipes_ingredients)
    |> validate_required([:name, :description])
  end
end

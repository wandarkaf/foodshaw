defmodule Foodies.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Recipes.{Recipe, RecipeIngredient}

  schema "ingredients" do
    field :description, :string
    field :name, :string
    many_to_many :recipes, Recipe, join_through: RecipeIngredient

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end

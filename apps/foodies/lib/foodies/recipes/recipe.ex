defmodule Foodies.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Repo
  alias Foodies.Recipes.{Ingredient, RecipeIngredient}

  schema "recipes" do
    field :description, :string
    field :name, :string
    many_to_many :ingredients, Ingredient, join_through: RecipeIngredient

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  # n to n relation in auto mode
  def changeset_update_ingredients(recipe, ingredients) do
    recipe
    |> Repo.preload(:ingredients)
    |> change()
    |> put_assoc(:ingredients, ingredients)
  end
end

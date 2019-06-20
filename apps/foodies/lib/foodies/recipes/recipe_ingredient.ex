defmodule Foodies.Recipes.RecipeIngredient do
  use Ecto.Schema

  #   @primary_key false
  schema "recipes_ingredients" do
    belongs_to :recipe, Foodies.Recipes.Recipe
    belongs_to :ingredient, Foodies.Recipes.Ingredient
    belongs_to :measure, Foodies.Recipes.Measure

    field :quantity, :decimal

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:recipe_id, :ingredient_id, :measure_id, :quantity])
    |> Ecto.Changeset.validate_required([:recipe_id, :ingredient_id, :measure_id, :quantity])
  end
end

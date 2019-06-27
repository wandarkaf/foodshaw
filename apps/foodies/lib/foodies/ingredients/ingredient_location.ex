defmodule Foodies.Ingredients.IngredientLocation do
  use Ecto.Schema

  @primary_key false
  schema "ingredients_locations" do
    belongs_to :ingredient, Foodies.Ingredients.Ingredient, primary_key: true
    belongs_to :location, Foodies.Ingredients.Location, primary_key: true
    # Added bonus, a join schema will also allow you to set timestamps
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:ingredient_id, :location_id])
    |> Ecto.Changeset.validate_required([:ingredient_id, :location_id])
  end
end

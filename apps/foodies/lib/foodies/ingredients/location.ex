defmodule Foodies.Ingredients.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Ingredients.{Ingredient, IngredientLocation}

  schema "locations" do
    field :name, :string
    field :description, :string
    field :lat, :float
    field :lng, :float
    field :ratio, :float

    many_to_many(
      :ingredients,
      Ingredient,
      join_through: IngredientLocation,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :description, :lat, :lng, :radio])
    |> validate_required([:name, :description, :lat, :lng, :radio])
  end
end

# Location |> Repo.all() |> Repo.preload(:ingredients)   
# ingredient = Repo.get!(Ingredient, 1) 
# Ingredients.upsert_ingredient_locations(ingredient, [1])   

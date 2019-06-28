defmodule Foodies.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Repo
  alias Foodies.Recipes.{RecipeIngredient, Instruction, Category}
  # alias Foodies.Recipes.{Ingredient, RecipeIngredient, Instruction}

  schema "recipes" do
    field :description, :string
    field :name, :string
    field :source_url, :string
    field :img_cover_url, :string
    field :spicy, :integer
    field :servings, :integer
    # many_to_many :ingredients, Ingredient, join_through: RecipeIngredient
    has_many :recipes_ingredients, RecipeIngredient
    has_many :instructions, Instruction
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [
      :name,
      :description,
      :source_url,
      :img_cover_url,
      :spicy,
      :servings,
      :category_id
    ])
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

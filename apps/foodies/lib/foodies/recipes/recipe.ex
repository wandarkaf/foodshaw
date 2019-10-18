defmodule Foodies.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Foodies.Repo
  alias Foodies.Recipes.{RecipeIngredient, Instruction, Category}
  alias Foodies.Ingredients.{Ingredient}

  schema "recipes" do
    field :description, :string
    field :name, :string
    field :source_url, :string
    field :img_cover_url, :string
    field :spicy, :integer
    field :servings, :integer

    # many_to_many :ingredients, Ingredient, join_through: RecipeIngredient, on_replace: :delete
    has_many :recipes_ingredients, RecipeIngredient
    has_many :instructions, Instruction

    many_to_many(
      :categories,
      Category,
      join_through: "recipes_categories",
      on_replace: :delete
    )

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
      :servings
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

  def changeset_update_categories(recipe, categories) do
    recipe
    |> Repo.preload(:categories)
    |> change()
    |> put_assoc(:categories, categories)
  end

  def changeset_categories(struct, categories, params \\ %{}) do
    struct
    |> cast(params, [
      :name,
      :description,
      :source_url,
      :img_cover_url,
      :spicy,
      :servings
    ])
    |> validate_required([:name, :description, :source_url, :servings])
    |> put_assoc(:categories, categories)
  end

  # recipe = Recipe.insert_or_update_recipe_with_categories(%Recipe{}, %{name: "test", description: "cualquier vaina para el test bro", source_url: "https://www.allrecipes.com/recipe/213268/classic-goulash/", servings: 2, categories: ["food", "carnivore"]}) 
  # Recipe |> Repo.get(3) |> Repo.preload(:categories)
  def insert_or_update_recipe_with_categories(recipe, params) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:categories, fn _, changes ->
      insert_and_get_all_categories(changes, params.categories || [])
    end)
    |> Ecto.Multi.run(:recipe, fn _, changes ->
      insert_or_update_recipe(changes, recipe, params)
    end)
    |> Repo.transaction()
  end

  defp insert_and_get_all_categories(_changes, params) do
    case params do
      [] ->
        {:ok, []}

      names ->
        timestamp = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
        maps = Enum.map(names, &%{name: &1, inserted_at: timestamp, updated_at: timestamp})
        Repo.insert_all(Category, maps, on_conflict: :nothing)
        query = from t in Category, where: t.name in ^names
        {:ok, Repo.all(query)}
    end
  end

  defp insert_or_update_recipe(%{categories: categories}, recipe, params) do
    recipe = changeset_categories(recipe, categories, params)
    Repo.insert_or_update(recipe)
  end
end

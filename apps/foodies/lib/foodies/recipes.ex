defmodule Foodies.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Foodies.Repo

  alias Foodies.Recipes.{Recipe, RecipeIngredient, Measure, Category}
  alias Foodies.Ingredients.Ingredient

  @doc """
  Returns the list of measures.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes(criteria) do
    query = from(r in Recipe)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from r in query, limit: ^limit

      {:filter, filters}, query ->
        filter_with(filters, query)

      {:order, order}, query ->
        from r in query, order_by: [{^order, :id}]
    end)
    |> Repo.all()
  end

  defp filter_with(filters, query) do
    Enum.reduce(filters, query, fn
      {:matching, term}, query ->
        pattern = "%#{term}%"

        from q in query,
          where:
            ilike(q.name, ^pattern) or
              ilike(q.description, ^pattern)

      # {:exclude, term}, query ->
      #   pattern = "%#{term}%"

      # from q in query,
      # join: ri in RecipeIngredient,
      # join: i in Ingredient,
      # where: not(
      #     from i in Ingredient,
      #     where: ilike(i.name, ^pattern) or ilike(i.description, ^pattern)
      #   )

      {:spicy, count}, query ->
        from q in query, where: q.spicy >= ^count

      {:servings, count}, query ->
        from q in query, where: q.servings >= ^count

      {:category, category}, query ->
        pattern = "%#{category}%"

        from q in query,
          join: c in Category,
          where: ilike(c.name, ^pattern) and c.id == q.category_id
    end)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end

  def add_ingredient_to_recipe(attrs) do
    # %{recipe_id: 2, ingredient_id: 21, measure_id: 3, quantity: 2}
    %RecipeIngredient{}
    |> RecipeIngredient.changeset(attrs)
    |> Repo.insert()
  end

  def get_recipe_ingredients(id) do
    RecipeIngredient
    |> join(:inner, [ri], i in assoc(ri, :ingredient))
    |> join(:inner, [ri], m in assoc(ri, :measure))
    |> select([ri, i, m], {i.name, ri.quantity, m.type})
    |> where([ri, i, m], ri.recipe_id == ^id)
    |> Repo.all()
  end

  @doc """
  Returns the list of measures.

  ## Examples

      iex> list_measures()
      [%Measure{}, ...]

  """
  def list_measures do
    Repo.all(Measure)
  end

  @doc """
  Gets a single measure.

  Raises `Ecto.NoResultsError` if the measure does not exist.

  ## Examples

      iex> get_measure!(123)
      %Measure{}

      iex> get_measure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_measure!(id), do: Repo.get!(Measure, id)

  def upsert_recipe_categories(recipe, categories_ids) when is_list(categories_ids) do
    categories =
      Category
      |> where([category], category.id in ^categories_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           recipe
           |> Recipe.changeset_update_categories(categories)
           |> Repo.update() do
      {:ok, get_recipe!(recipe.id)}
    else
      error ->
        error
    end
  end

  # Dataloader

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Ingredient, %{limit: limit, scope: :recipe}) do
    Ingredient
    # |> where(state: "reserved")
    # |> order_by(asc: :start_date)
    |> limit(^limit)

    # get_recipe_ingredients(Ingredient)
  end

  # def query(Ingredient, %{scope: :user}) do
  #   Ingredient
  #   |> order_by(asc: :start_date)
  # end

  def query(Ingredient, %{scope: :measurements}) do
    IO.inspect(Ingredient)
    Ingredient
  end

  def query(queryable, _) do
    queryable
  end
end

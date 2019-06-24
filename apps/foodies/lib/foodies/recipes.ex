defmodule Foodies.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Foodies.Repo

  alias Foodies.Recipes.{Recipe, Ingredient, RecipeIngredient, Measure, Category}

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

      {:exclude, term}, query ->
        pattern = "%#{term}%"

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

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients(criteria) do
    query = from(i in Ingredient)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from i in query, limit: ^limit

      {:filter, filters}, query ->
        filter_with(filters, query)

      {:order, order}, query ->
        from i in query, order_by: [{^order, :id}]
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient) do
    Ingredient.changeset(ingredient, %{})
  end

  def upsert_recipe_ingredients(ingredients) do
    # %{recipe_id: recipe.id, ingredient_id: 2, quantity: 100}
    Enum.map(
      ingredients,
      fn ingredient ->
        changeset = RecipeIngredient.changeset(%RecipeIngredient{}, ingredient)

        case Repo.insert(changeset) do
          {:ok, assoc} -> assoc
          {:error, changeset} -> :error
        end
      end
    )
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

  def query(queryable, _) do
    queryable
  end
end

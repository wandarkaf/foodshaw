defmodule Foodies.Ingredients do
  @moduledoc """
  The Ingredients context.
  """

  import Ecto.Query, warn: false
  alias Foodies.Repo

  alias Foodies.Ingredients.{Ingredient, Location}

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

      # {:filter, filters}, query ->
      #   filter_with(filters, query)

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

  def upsert_ingredient_locations(ingredient, locations_ids) when is_list(locations_ids) do
    locations =
      Location
      |> where([location], location.id in ^locations_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           ingredient
           |> Ingredient.changeset_update_locations(locations)
           |> Repo.update() do
      {:ok, get_ingredient!(ingredient.id)}
    else
      error ->
        error
    end
  end

  # Dataloader

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Ingredient, %{limit: limit, scope: :ingredient}) do
    Ingredient
    # |> where(state: "reserved")
    # |> order_by(asc: :start_date)
    |> limit(^limit)
  end

  # def query(Ingredient, %{scope: :user}) do
  #   Ingredient
  #   |> order_by(asc: :start_date)
  # end

  def query(queryable, _) do
    queryable
  end
end

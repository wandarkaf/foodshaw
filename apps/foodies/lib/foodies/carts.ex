defmodule Foodies.Carts do
  @moduledoc """
  The Carts context.
  """

  import Ecto.Query, warn: false
  alias Foodies.Repo

  alias Foodies.Carts.Cart

  @doc """
  Returns the list of carts.

  ## Examples

      iex> list_carts()
      [%Cart{}, ...]

  """
  def list_carts do
    Repo.all(Cart)
  end

  @doc """
  Gets a single cart.

  Raises `Ecto.NoResultsError` if the Cart does not exist.

  ## Examples

      iex> get_cart!(123)
      %Cart{}

      iex> get_cart!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart!(id), do: Repo.get!(Cart, id)

  @doc """
  Creates a cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cart.

  ## Examples

      iex> update_cart(cart, %{field: new_value})
      {:ok, %Cart{}}

      iex> update_cart(cart, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart(%Cart{} = cart, attrs) do
    cart
    |> Cart.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Cart.

  ## Examples

      iex> delete_cart(cart)
      {:ok, %Cart{}}

      iex> delete_cart(cart)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart(%Cart{} = cart) do
    Repo.delete(cart)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart changes.

  ## Examples

      iex> change_cart(cart)
      %Ecto.Changeset{source: %Cart{}}

  """
  def change_cart(%Cart{} = cart) do
    Cart.changeset(cart, %{})
  end

  alias Foodies.Carts.CartIngredient

  @doc """
  Returns the list of carts_ingredients.

  ## Examples

      iex> list_carts_ingredients()
      [%CartIngredient{}, ...]

  """
  def list_carts_ingredients do
    Repo.all(CartIngredient)
  end

  @doc """
  Gets a single cart_ingredient.

  Raises `Ecto.NoResultsError` if the Cart ingredient does not exist.

  ## Examples

      iex> get_cart_ingredient!(123)
      %CartIngredient{}

      iex> get_cart_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart_ingredient!(id), do: Repo.get!(CartIngredient, id)

  @doc """
  Creates a cart_ingredient.

  ## Examples

      iex> create_cart_ingredient(%{field: value})
      {:ok, %CartIngredient{}}

      iex> create_cart_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart_ingredient(attrs \\ %{}) do
    %CartIngredient{}
    |> CartIngredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cart_ingredient.

  ## Examples

      iex> update_cart_ingredient(cart_ingredient, %{field: new_value})
      {:ok, %CartIngredient{}}

      iex> update_cart_ingredient(cart_ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart_ingredient(%CartIngredient{} = cart_ingredient, attrs) do
    cart_ingredient
    |> CartIngredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CartIngredient.

  ## Examples

      iex> delete_cart_ingredient(cart_ingredient)
      {:ok, %CartIngredient{}}

      iex> delete_cart_ingredient(cart_ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart_ingredient(%CartIngredient{} = cart_ingredient) do
    Repo.delete(cart_ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart_ingredient changes.

  ## Examples

      iex> change_cart_ingredient(cart_ingredient)
      %Ecto.Changeset{source: %CartIngredient{}}

  """
  def change_cart_ingredient(%CartIngredient{} = cart_ingredient) do
    CartIngredient.changeset(cart_ingredient, %{})
  end
end

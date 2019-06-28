defmodule Foodies.CartsTest do
  use Foodies.DataCase

  alias Foodies.Carts

  describe "carts_ingredients" do
    alias Foodies.Carts.CartIngredient

    @valid_attrs %{"": "120.5", checked: "some checked", quantity: "some quantity"}
    @update_attrs %{
      "": "456.7",
      checked: "some updated checked",
      quantity: "some updated quantity"
    }
    @invalid_attrs %{"": nil, checked: nil, quantity: nil}

    def cart_ingredient_fixture(attrs \\ %{}) do
      {:ok, cart_ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Carts.create_cart_ingredient()

      cart_ingredient
    end

    test "list_carts_ingredients/0 returns all carts_ingredients" do
      cart_ingredient = cart_ingredient_fixture()
      assert Carts.list_carts_ingredients() == [cart_ingredient]
    end

    test "get_cart_ingredient!/1 returns the cart_ingredient with given id" do
      cart_ingredient = cart_ingredient_fixture()
      assert Carts.get_cart_ingredient!(cart_ingredient.id) == cart_ingredient
    end

    test "create_cart_ingredient/1 with valid data creates a cart_ingredient" do
      assert {:ok, %CartIngredient{} = cart_ingredient} =
               Carts.create_cart_ingredient(@valid_attrs)

      assert cart_ingredient.==(Decimal.new("120.5"))
      assert cart_ingredient.checked == "some checked"
      assert cart_ingredient.quantity == "some quantity"
    end

    test "create_cart_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Carts.create_cart_ingredient(@invalid_attrs)
    end

    test "update_cart_ingredient/2 with valid data updates the cart_ingredient" do
      cart_ingredient = cart_ingredient_fixture()

      assert {:ok, %CartIngredient{} = cart_ingredient} =
               Carts.update_cart_ingredient(cart_ingredient, @update_attrs)

      assert cart_ingredient.==(Decimal.new("456.7"))
      assert cart_ingredient.checked == "some updated checked"
      assert cart_ingredient.quantity == "some updated quantity"
    end

    test "update_cart_ingredient/2 with invalid data returns error changeset" do
      cart_ingredient = cart_ingredient_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Carts.update_cart_ingredient(cart_ingredient, @invalid_attrs)

      assert cart_ingredient == Carts.get_cart_ingredient!(cart_ingredient.id)
    end

    test "delete_cart_ingredient/1 deletes the cart_ingredient" do
      cart_ingredient = cart_ingredient_fixture()
      assert {:ok, %CartIngredient{}} = Carts.delete_cart_ingredient(cart_ingredient)
      assert_raise Ecto.NoResultsError, fn -> Carts.get_cart_ingredient!(cart_ingredient.id) end
    end

    test "change_cart_ingredient/1 returns a cart_ingredient changeset" do
      cart_ingredient = cart_ingredient_fixture()
      assert %Ecto.Changeset{} = Carts.change_cart_ingredient(cart_ingredient)
    end
  end
end

defmodule Foodies.ListsTest do
  use Foodies.DataCase

  alias Foodies.Lists

  describe "carts" do
    alias Foodies.Lists.Cart

    @valid_attrs %{
      "": 42,
      description: "some description",
      name: "some name",
      reset: "some reset"
    }
    @update_attrs %{
      "": 43,
      description: "some updated description",
      name: "some updated name",
      reset: "some updated reset"
    }
    @invalid_attrs %{"": nil, description: nil, name: nil, reset: nil}

    def cart_fixture(attrs \\ %{}) do
      {:ok, cart} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lists.create_cart()

      cart
    end

    test "list_carts/0 returns all carts" do
      cart = cart_fixture()
      assert Lists.list_carts() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Lists.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      assert {:ok, %Cart{} = cart} = Lists.create_cart(@valid_attrs)
      assert cart.==(42)
      assert cart.description == "some description"
      assert cart.name == "some name"
      assert cart.reset == "some reset"
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_cart(@invalid_attrs)
    end

    test "update_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{} = cart} = Lists.update_cart(cart, @update_attrs)
      assert cart.==(43)
      assert cart.description == "some updated description"
      assert cart.name == "some updated name"
      assert cart.reset == "some updated reset"
    end

    test "update_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = Lists.update_cart(cart, @invalid_attrs)
      assert cart == Lists.get_cart!(cart.id)
    end

    test "delete_cart/1 deletes the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{}} = Lists.delete_cart(cart)
      assert_raise Ecto.NoResultsError, fn -> Lists.get_cart!(cart.id) end
    end

    test "change_cart/1 returns a cart changeset" do
      cart = cart_fixture()
      assert %Ecto.Changeset{} = Lists.change_cart(cart)
    end
  end
end

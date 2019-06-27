defmodule Foodies.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :description, :string
    field :name, :string
    field :reset, :integer
    field :share, {:array, :string}

    belongs_to :user, Foodies.Accounts.User
    has_many :carts_ingredients, Foodies.Carts.CartIngredient

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:name, :description, :reset, :share])
    |> validate_required([:name, :description, :reset, :share])
  end
end

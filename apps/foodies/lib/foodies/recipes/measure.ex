defmodule Foodies.Recipes.Measure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "measures" do
    field :type, :string
    field :abbreviaton, :string
    field :description, :string
    field :img_cover_url, :string
    field :weight, :decimal

    timestamps()
  end

  @doc false
  def changeset(measure, attrs) do
    measure
    |> cast(attrs, [:type, :abbreviaton, :description, :img_cover_url, :weight])
    |> validate_required([:type, :abbreviaton, :description, :weight])
  end
end

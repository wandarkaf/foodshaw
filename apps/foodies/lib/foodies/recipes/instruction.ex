defmodule Foodies.Recipes.Instruction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodies.Recipes.Recipe

  schema "instructions" do
    field :preparation, :string
    field :time, :decimal
    belongs_to :recipe, Recipe

    timestamps()
  end

  @doc false
  def changeset(instruction, attrs) do
    instruction
    |> cast(attrs, [:preparation, :time, :recipe_id])
    |> validate_required([:preparation])
  end
end

defmodule FoodiesWeb.Resolvers.Ingredients do
  alias Foodies.Ingredients
  alias FoodiesWeb.Schema.ChangesetErrors

  def ingredients(_, args, _) do
    {:ok, Ingredients.list_ingredients(args)}
  end
end

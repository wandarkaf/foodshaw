defmodule FoodiesWeb.Resolvers.Recipes do
  alias Foodies.Recipes
  # alias FoodiesWeb.Schema.ChangesetErrors

  def recipes(_, args, _) do
    {:ok, Foodies.Recipes.list_recipes()}
  end
end

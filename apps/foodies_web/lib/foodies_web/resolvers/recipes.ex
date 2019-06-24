defmodule FoodiesWeb.Resolvers.Recipes do
  alias Foodies.Recipes
  # alias FoodiesWeb.Schema.ChangesetErrors

  def recipes(_, args, _) do
    {:ok, Foodies.Recipes.list_recipes(args)}
  end

  def recipe(_, %{id: id}, _) do
    {:ok, Foodies.Recipes.get_recipe!(id)}
  end

  def ingredients(_, args, _) do
    {:ok, Foodies.Recipes.list_ingredients(args)}
  end
end

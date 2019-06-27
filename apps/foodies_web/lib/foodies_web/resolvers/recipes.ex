defmodule FoodiesWeb.Resolvers.Recipes do
  alias Foodies.Recipes
  alias FoodiesWeb.Schema.ChangesetErrors

  def recipes(_, args, _) do
    {:ok, Recipes.list_recipes(args)}
  end

  def recipe(_, %{id: id}, _) do
    {:ok, Recipes.get_recipe!(id)}
  end

  def add_ingredient_to_recipe(_, args, %{context: %{current_user: user}}) do
    case Recipes.add_ingredient_to_recipe(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not add ingredient to recipe!",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, ingredient} ->
        publish_ingredient_change(ingredient)
        {:ok, ingredient}
    end
  end

  defp publish_ingredient_change(ingredient) do
    Absinthe.Subscription.publish(
      FoodiesWeb.Endpoint,
      ingredient,
      ingredient_change: ingredient.recipe_id
    )
  end
end

defmodule FoodiesWeb.Schema.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  import_types(Absinthe.Type.Custom)

  alias FoodiesWeb.Resolvers
  # alias FoodiesWeb.Schema.Middleware
  alias Foodies.{Accounts, Recipes}

  query do
    @desc "Get a list of recipes"
    field :recipes, list_of(:recipe) do
      arg(:filter, :recipe_filter)
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Recipes.recipes/3)
    end
  end

  #
  # Object Types
  #

  object :recipe do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:description, non_null(:string))
    field(:source_url, non_null(:string))
    field(:img_cover_url, non_null(:string))
    field(:spicy, non_null(:integer))
    field(:servings, non_null(:integer))
    field(:category, non_null(:category), resolve: dataloader(Recipes))

    field :instructions, list_of(:instruction) do
      resolve(dataloader(Recipes, :instructions, args: %{scope: :recipe}))
    end

    field :ingredients, list_of(:recipes_ingredients) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(Recipes, :recipes_ingredients, args: %{scope: :recipe}))
    end
  end

  object :ingredient do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:description, non_null(:string))
    field(:img_cover_url, non_null(:string))
    # field :recipes, non_null(:recipes_ingredients), resolve: dataloader(Recipes)
    field :recipes, list_of(:recipes_ingredients) do
      arg(:limit, type: :integer, default_value: 3)
      resolve(dataloader(Recipes, :recipes_ingredients, args: %{scope: :recipe}))
    end
  end

  object :measure do
    field(:id, non_null(:id))
    field(:type, non_null(:string))
    field(:abbreviaton, non_null(:string))
    field(:description, non_null(:string))
    field(:img_cover_url, non_null(:string))
    field(:weight, non_null(:decimal))
  end

  object :instruction do
    field(:id, non_null(:id))
    field(:recipe_id, non_null(:id))
    field(:preparation, non_null(:string))
    field(:time, non_null(:decimal))
  end

  object :category do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
  end

  object :recipes_ingredients do
    field(:id, non_null(:id))
    field(:recipe_id, non_null(:id))
    field(:ingredient_id, non_null(:id))
    field(:measure_id, non_null(:id))
    field(:quantity, non_null(:decimal))
    field(:ingredient, non_null(:ingredient), resolve: dataloader(Recipes))
    field(:measure, non_null(:measure), resolve: dataloader(Recipes))
  end

  #
  # Input Object Types
  #

  @desc "Filters for the list of recipes"
  input_object :recipe_filter do
    @desc "Matching a name or description"
    field(:matching, :string)

    @desc "spice level"
    field(:spicy, :integer)

    @desc "number of servings"
    field(:servings, :integer)

    @desc "category of the recipe"
    field(:category, :string)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  #
  # Data Loader
  #

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Recipes, Recipes.datasource())

    # |> Dataloader.add_source(Accounts, Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end

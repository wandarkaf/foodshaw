defmodule FoodiesWeb.Schema.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  import_types(Absinthe.Type.Custom)

  alias FoodiesWeb.Resolvers
  alias FoodiesWeb.Schema.Middleware
  alias Foodies.{Accounts, Recipes, Ingredients}

  query do
    @desc "Get a list of recipes"
    field :recipes, list_of(:recipe) do
      arg(:filter, :recipe_filter)
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)
      resolve(&Resolvers.Recipes.recipes/3)
    end

    @desc "Get a recipe by id"
    field :recipe, :recipe do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Recipes.recipe/3)
    end

    @desc "Get a list of ingredients"
    field :ingredients, list_of(:ingredient) do
      arg(:filter, :ingredient_filter)
      arg(:limit, :integer)
      arg(:order, type: :sort_order, default_value: :asc)
      # middleware Middleware.Authenticate
      resolve(&Resolvers.Ingredients.ingredients/3)
    end

    @desc "Get the currently signed-in user"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end
  end

  mutation do
    @desc "Add a ingredient to a recipe"
    field :add_ingredient_to_recipe, :recipes_ingredients do
      # %{recipe_id: 2, ingredient_id: 21, measure_id: 3, quantity: 2}
      arg(:recipe_id, non_null(:id))
      arg(:ingredient_id, non_null(:id))
      arg(:measure_id, non_null(:id))
      arg(:quantity, non_null(:decimal))
      middleware(Middleware.Authenticate)
      resolve(&Resolvers.Recipes.add_ingredient_to_recipe/3)
    end

    @desc "Create a user account"
    field :signup, :session do
      arg(:name, non_null(:string))
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:role, non_null(:string))
      resolve(&Resolvers.Accounts.signup/3)
    end

    @desc "Sign in a user"
    field :signin, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.signin/3)
    end
  end

  subscription do
    @desc "Subscribe to ingredients changes for a recipe"
    field :ingredient_change, :recipes_ingredients do
      arg(:recipe_id, non_null(:id))

      config(fn args, _info ->
        {:ok, topic: args.recipe_id}
      end)
    end
  end

  #
  # Object Types
  #

  #  Recipes

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

  object :measure do
    fiel(:id, non_null(:id))
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
    field(:recipe_id, non_null(:id))
    field(:ingredient_id, non_null(:id))
    field(:measure_id, non_null(:id))
    field(:quantity, non_null(:decimal))
    field(:ingredient, non_null(:ingredient), resolve: dataloader(Ingredients))
    field(:recipe, non_null(:recipe), resolve: dataloader(Recipes))
    field(:measure, non_null(:measure), resolve: dataloader(Recipes))
  end

  # Ingredients

  object :ingredient do
    fiel(:id, non_null(:id))
    fiel(:name, non_null(:string))
    fiel(:description, non_null(:string))
    fiel(:img_cover_url, non_null(:string))
    # field :recipes, non_null(:recipes_ingredients), resolve: dataloader(Recipes)
    field :recipes, list_of(:recipes_ingredients) do
      arg(:limit, type: :integer, default_value: 3)
      resolve(dataloader(Recipes, :recipes_ingredients, args: %{scope: :recipe}))
    end
  end

  # Users

  object :user do
    field(:username, non_null(:string))
    field(:name, non_null(:string))
    field(:credential, non_null(:credential), resolve: dataloader(Accounts))
  end

  object :session do
    field(:token, non_null(:string))
    field(:user, non_null(:user))
  end

  object :credential do
    field(:email, non_null(:string))
    field(:role, non_null(:string))
  end

  #
  # Input Object Types
  #

  @desc "Filters for the list of recipes"
  input_object :recipe_filter do
    @desc "Matching a name or description"
    field(:matching, :string)

    @desc "Exclude recipe that contains the keyword in the ingredients"
    field(:exclude, :string)

    @desc "spice level"
    field(:spicy, :integer)

    @desc "number of servings"
    field(:servings, :integer)

    @desc "category of the recipe"
    field(:category, :string)
  end

  @desc "Filters for the list of ingredients"
  input_object :ingredient_filter do
    @desc "Matching a name or description"
    field(:matching, :string)

    @desc "Exclude recipes matching a name or description"
    field(:exclude, :string)
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
      |> Dataloader.add_source(Ingredients, Ingredients.datasource())
      |> Dataloader.add_source(Accounts, Accounts.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end

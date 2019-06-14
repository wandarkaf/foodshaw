defmodule FoodiesWeb.Schema.Schema do
  use Absinthe.Schema
  # import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  import_types(Absinthe.Type.Custom)

  alias FoodiesWeb.Resolvers
  # alias FoodiesWeb.Schema.Middleware
  alias Foodies.{Accounts, Recipes}

  query do
    @desc "Get a list of recipes"
    field :recipes, list_of(:recipe) do
      # arg :filter, :place_filter
      arg(:limit, :integer)
      # arg :order, type: :sort_order, default_value: :asc
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
  end
end

defmodule FoodiesWeb.Router do
  use FoodiesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug FoodiesWeb.Plugs.SetCurrentUser
  end

  scope "/", FoodiesWeb do
    pipe_through :api
    get "/", WelcomeController, :index
  end

  # scope "/api", FoodiesWeb do
  #   pipe_through :api

  #   scope "/accounts", Accounts do
  #     resources "/users", UserController
  #   end
  # end

  # pipeline :api do
  #   plug :accepts, ["json"]
  #   plug FoodiesWeb.Plugs.SetCurrentUser
  # end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: FoodiesWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: FoodiesWeb.Schema.Schema,
      socket: FoodiesWeb.UserSocket

    # interface: :simple
  end
end

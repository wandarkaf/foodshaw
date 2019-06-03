defmodule FoodiesWeb.Router do
  use FoodiesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodiesWeb do
    pipe_through :api
    get "/", WelcomeController, :index
  end

  scope "/api", FoodiesWeb do
    pipe_through :api

    scope "/accounts", Accounts do
      resources "/users", UserController
    end
  end
end

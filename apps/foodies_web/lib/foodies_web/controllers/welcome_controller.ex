defmodule FoodiesWeb.WelcomeController do
  use FoodiesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end

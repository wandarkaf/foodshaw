defmodule FoodiesWeb.WelcomeView do
  use FoodiesWeb, :view
  alias FoodiesWeb.WelcomeView

  def render("index.json", _) do
    # %{data: render_many(%{welcome: "Welcome to our api"}, WelcomeView, "index.json")}
    %{welcome: "Welcome to our api"}
  end
end

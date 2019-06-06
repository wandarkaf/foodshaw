# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Foodies.Repo.insert!(%Foodies.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Foodies.Accounts
alias Foodies.Recipes

# Accounts.create_user(%User{name: "Alonso", username: "Wandarkaf"})
Accounts.register_user(%{
  name: "alonso",
  username: "wandarkaf",
  credential: %{
    email: "lamas.alonso@gmail.com",
    password: "123456",
    role: "admin"
  }
})

Recipes.create_recipe(%{
  name: "The Best Chocolate Chip Cookie Recipe Ever",
  description:
    "This is the best chocolate chip cookie recipe ever! No funny ingredients, no chilling time, etc. Just a simple, straightforward, amazingly delicious, doughy yet still fully cooked, chocolate chip cookie that turns out perfectly every single time!"
})

Recipes.create_ingredient(%{
  name: "salted butter",
  description: "it's butter, but salted"
})

Recipes.create_ingredient(%{
  name: "white (granulated) sugar",
  description: "from the cane"
})

Recipes.create_ingredient(%{
  name: "light brown sugar packed",
  description: "unrefined"
})

Recipes.create_ingredient(%{
  name: "pure vanilla extract",
  description: "plant that looks like a stick"
})

Recipes.create_ingredient(%{
  name: "Egg",
  description: "Chicken babies"
})

Recipes.create_ingredient(%{
  name: "all-purpose flour",
  description: "Harina, harina"
})

Recipes.create_ingredient(%{
  name: "baking soda",
  description: "magical powder"
})

Recipes.create_ingredient(%{
  name: "baking powder",
  description: "magical powder"
})

Recipes.create_ingredient(%{
  name: "salt",
  description: "grains from the ground"
})

Recipes.create_ingredient(%{
  name: "chocolate chips",
  description: "ohhh yeahh!!"
})

# 1 cup white (granulated) sugar
# 1 cup light brown sugar packed
# 2 tsp pure vanilla extract
# 2 large eggs
# 3 cups all-purpose flour
# 1 tsp baking soda
# ½ tsp baking powder
# 1 tsp sea salt
# 2 cups chocolate chips (or chunks, or chopped chocolate)

ingredients = [
  %{recipe_id: 1, ingredient_id: 1, quantity: 1},
  %{recipe_id: 1, ingredient_id: 2, quantity: 1},
  %{recipe_id: 1, ingredient_id: 1, quantity: 1},
  %{recipe_id: 1, ingredient_id: 4, quantity: 2},
  %{recipe_id: 1, ingredient_id: 5, quantity: 3},
  %{recipe_id: 1, ingredient_id: 6, quantity: 1},
  %{recipe_id: 1, ingredient_id: 7, quantity: 1},
  %{recipe_id: 1, ingredient_id: 8, quantity: 1},
  %{recipe_id: 1, ingredient_id: 9, quantity: 2}
]

Recipes.upsert_recipe_ingredients(ingredients)

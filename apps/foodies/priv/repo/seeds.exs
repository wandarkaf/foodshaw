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
alias Foodies.Repo
alias Foodies.Accounts
# alias Foodies.Recipes
alias Foodies.Recipes.{Recipe, RecipeIngredient, Category, Instruction, Measure}
alias Foodies.Ingredients.{Ingredient, IngredientLocation, Location}
alias Foodies.Carts.{Cart, CartIngredient}

# USERS

Accounts.register_user(%{
  name: "alonso",
  username: "wandarkaf",
  credential: %{
    email: "lamas.alonso@gmail.com",
    password: "123456",
    role: "admin"
  }
})

# CATEGORY

Repo.insert!(%Category{
  name: "vegetarian"
})

Repo.insert!(%Category{
  name: "semi-vegetarian"
})

Repo.insert!(%Category{
  name: "carnivore"
})

# RECIPES

Repo.insert!(%Recipe{
  name: "The Best Chocolate Chip Cookie Recipe Ever",
  description:
    "This is the best chocolate chip cookie recipe ever! No funny ingredients, no chilling time, etc. Just a simple, straightforward, amazingly delicious, doughy yet still fully cooked, chocolate chip cookie that turns out perfectly every single time!",
  source_url: "https://joyfoodsunshine.com/the-most-amazing-chocolate-chip-cookies/",
  img_cover_url:
    "https://joyfoodsunshine.com/wp-content/uploads/2016/01/best-chocolate-chip-cookies-recipe-ever-no-chilling-1.jpg",
  spicy: 2,
  servings: 2,
  category_id: 1
})

Repo.insert!(%Recipe{
  name: "Classic Goulash",
  description:
    "Easy recipe for making a classic goulash. Can also be done in a slow cooker. Inspired by Paula Deen's Bobby's Goulash.",
  source_url: "https://www.allrecipes.com/recipe/213268/classic-goulash/",
  img_cover_url: "https://www.allrecipes.com/recipe/213268/classic-goulash/",
  servings: 4,
  category_id: 3
})

# INSTRUCTIONS

Repo.insert!(%Instruction{
  preparation:
    "Soften butter. If you are planning on making these, take the butter out of the fridge first thing in the morning so it’s ready to go when you need it!",
  time: 5.5,
  recipe_id: 1
})

Repo.insert!(%Instruction{
  preparation:
    "Measure the flour correctly. Be sure to use a measuring cup made for dry ingredients (NOT a pyrex liquid measuring cup), and do not use a knife to level the flour. Instead, fill the measuring cup over-full and shake off the excess until you have a level 1 cup.",
  time: 2,
  recipe_id: 1
})

Repo.insert!(%Instruction{
  preparation: "Use LOTS of chocolate chips. Do I really need to explain this?!",
  time: 2,
  recipe_id: 1
})

Repo.insert!(%Instruction{
  preparation:
    "DO NOT over-bake these chocolate chip cookies! I explain this more below, but these chocolate chip cookies will not look done when you pull them out of the oven, and that is GOOD.",
  time: 30,
  recipe_id: 1
})

Repo.insert!(%Instruction{
  preparation: "
  Cook and stir the ground beef in a large Dutch oven over medium-high heat, breaking the meat up as it cooks, until the meat is no longer pink and has started to brown, about 10 minutes. Skim off excess fat, and stir in the onions and garlic. Cook and stir the meat mixture until the onions are translucent, about 10 more minutes.
",
  time: 10,
  recipe_id: 2
})

Repo.insert!(%Instruction{
  preparation:
    "Stir water, tomato sauce, diced tomatoes, soy sauce, Italian seasoning, bay leaves, and seasoned salt into the meat mixture and bring to a boil over medium heat. Reduce heat to low, cover, and simmer 20 minutes, stirring occasionally.",
  time: 20,
  recipe_id: 2
})

Repo.insert!(%Instruction{
  preparation:
    "Stir macaroni into the mixture, cover, and simmer over low heat until the pasta is tender, about 25 minutes, stirring occasionally. Remove from heat, discard bay leaves, and serve.",
  time: 25,
  recipe_id: 2
})

# MEASURES

Repo.insert!(%Measure{
  type: "teaspoon",
  abbreviaton: "tsp",
  description:
    "A teaspoon is a small spoon suitable for stirring and sipping the contents of a cup of tea or coffee, or adding a portion of loose sugar to it. These spoons have heads more or less oval in shape. Teaspoons are a common part of a place setting.",
  img_cover_url:
    "https://media.tiffany.com/is/image/Tiffany/10072492_933594_ED?$EcomItemL$&id=j2gqA2&fmt=jpg&fit=constrain,1&wid=300&hei=300",
  weight: 4.7
})

Repo.insert!(%Measure{
  type: "tablespoon",
  abbreviaton: "tbsp",
  description:
    "A tablespoon is a large spoon used for serving. In many English-speaking regions, the term now refers to a large spoon used for serving, however, in some regions, including parts of Canada, it is the largest type of spoon used for eating. ",
  weight: 14.3
})

Repo.insert!(%Measure{
  type: "cup",
  abbreviaton: "cup",
  description:
    "The cup is a cooking measure of volume, commonly associated with cooking and serving sizes. It is traditionally equal to half a liquid pint in US customary units or in the metric system at values between ​1⁄5 and ​1⁄4 of a litre. Because actual drinking cups may differ greatly from the size of this unit, standard measuring cups are usually used instead.",
  weight: 0.25
})

Repo.insert!(%Measure{
  type: "quantity",
  abbreviaton: "",
  description:
    "the amount or number of a material or immaterial thing not usually estimated by spatial measurement.",
  weight: 1
})

Repo.insert!(%Measure{
  type: "grams",
  abbreviaton: "gr",
  description:
    "the amount or number of a material or immaterial thing not usually estimated by spatial measurement.",
  weight: 1
})

Repo.insert!(%Measure{
  type: "kilograms",
  abbreviaton: "kg",
  description:
    "the amount or number of a material or immaterial thing not usually estimated by spatial measurement.",
  weight: 1
})

# INGREDIENTS

# for cookies

Repo.insert!(%Ingredient{
  name: "salted butter",
  description: "it's butter, but salted",
  img_cover_url:
    "https://www.thespruceeats.com/thmb/dhxKbohCXrcWCzLf-tYR8TI2Q0E=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/butter-2500-56a210e45f9b58b7d0c632aa.jpg"
})

Repo.insert!(%Ingredient{
  name: "white (granulated) sugar",
  description: "from the cane"
})

Repo.insert!(%Ingredient{
  name: "light brown sugar packed",
  description: "unrefined",
  img_cover_url:
    "https://www.kinder.com/documents/16871047/16978405/Sugar.jpg/bc182016-29c2-411f-9fba-8a55427edd0a"
})

Repo.insert!(%Ingredient{
  name: "pure vanilla extract",
  description: "plant that looks like a stick"
})

Repo.insert!(%Ingredient{
  name: "large eggs",
  description: "Chicken babies"
})

Repo.insert!(%Ingredient{
  name: "all-purpose flour",
  description: "Harina, harina"
})

Repo.insert!(%Ingredient{
  name: "baking soda",
  description: "magical powder"
})

Repo.insert!(%Ingredient{
  name: "baking powder",
  description: "magical powder"
})

Repo.insert!(%Ingredient{
  name: "sea salt",
  description: "grains from the ground"
})

Repo.insert!(%Ingredient{
  name: "chocolate chips (or chunks, or chopped chocolate)",
  description: "ohhh yeahh!!"
})

# for goulash

Repo.insert!(%Ingredient{
  name: "lean ground beef",
  description: "meat all around"
})

Repo.insert!(%Ingredient{
  name: "large yellow onions, chopped",
  description: "It will make you cry"
})

Repo.insert!(%Ingredient{
  name: "cloves garlic, chopped",
  description: "Good for the soul."
})

Repo.insert!(%Ingredient{
  name: "water",
  description: "Is everywhere, for the moment..."
})

Repo.insert!(%Ingredient{
  name: "tomato sauce",
  description: "or tomato"
})

Repo.insert!(%Ingredient{
  name: "diced tomatoes",
  description: "red and juicy"
})

Repo.insert!(%Ingredient{
  name: "soy sauce",
  description: "is salty",
  img_cover_url: "https://upload.wikimedia.org/wikipedia/commons/6/63/Soy_sauce_2.jpg"
})

Repo.insert!(%Ingredient{
  name: "dried Italian herb seasoning",
  description: "the flavor of south of europe"
})

Repo.insert!(%Ingredient{
  name: "bay leaves",
  description: "veggie shit"
})

Repo.insert!(%Ingredient{
  name: "seasoned salt",
  description: "meat all around"
})

Repo.insert!(%Ingredient{
  name: "uncooked elbow macaroni",
  description: "meat all around"
})

# RECIPE INGREDIENT RELATION

ingredients = [
  # cookies
  %{recipe_id: 1, ingredient_id: 1, measure_id: 3, quantity: 1},
  %{recipe_id: 1, ingredient_id: 2, measure_id: 3, quantity: 1},
  %{recipe_id: 1, ingredient_id: 3, measure_id: 3, quantity: 1},
  %{recipe_id: 1, ingredient_id: 4, measure_id: 1, quantity: 2},
  %{recipe_id: 1, ingredient_id: 5, measure_id: 4, quantity: 2},
  %{recipe_id: 1, ingredient_id: 6, measure_id: 3, quantity: 3},
  %{recipe_id: 1, ingredient_id: 7, measure_id: 1, quantity: 1},
  %{recipe_id: 1, ingredient_id: 8, measure_id: 1, quantity: 0.5},
  %{recipe_id: 1, ingredient_id: 9, measure_id: 1, quantity: 1},
  %{recipe_id: 1, ingredient_id: 10, measure_id: 3, quantity: 2},
  # goulash
  %{recipe_id: 2, ingredient_id: 11, measure_id: 6, quantity: 0.907185},
  %{recipe_id: 2, ingredient_id: 12, measure_id: 4, quantity: 2},
  %{recipe_id: 2, ingredient_id: 13, measure_id: 4, quantity: 3},
  %{recipe_id: 2, ingredient_id: 14, measure_id: 3, quantity: 3},
  %{recipe_id: 2, ingredient_id: 15, measure_id: 5, quantity: 425.243},
  %{recipe_id: 2, ingredient_id: 16, measure_id: 5, quantity: 411.06},
  %{recipe_id: 2, ingredient_id: 17, measure_id: 2, quantity: 3},
  %{recipe_id: 2, ingredient_id: 18, measure_id: 2, quantity: 2},
  %{recipe_id: 2, ingredient_id: 19, measure_id: 4, quantity: 3},
  %{recipe_id: 2, ingredient_id: 20, measure_id: 2, quantity: 1},
  %{recipe_id: 2, ingredient_id: 21, measure_id: 3, quantity: 2}
]

Enum.map(
  ingredients,
  fn ingredient ->
    changeset = RecipeIngredient.changeset(%RecipeIngredient{}, ingredient)
    Repo.insert!(changeset)
  end
)

# LOCATIONS

Repo.insert!(%Location{
  name: "evanston",
  description: "cool place to eat venezuelan food",
  lat: 42.0448053,
  lng: -87.7304106,
  ratio: 1.12312
})

Repo.insert!(%Location{
  name: "denver",
  description: "cool place to hike and farm",
  lat: 39.7645187,
  lng: -104.9951973,
  ratio: 3.2
})

# CARTS

Repo.insert!(%Cart{
  name: "Veggies",
  description: "Don't forget to buy stuff",
  reset: 0,
  share: [],
  user_id: 1
})

# CART INGREDIENT RELATION

to_shop = [
  %{cart_id: 1, ingredient_id: 1, checked: true, quantity: 1},
  %{cart_id: 1, ingredient_id: 2, checked: false, quantity: 4},
  %{cart_id: 1, ingredient_id: 3, checked: true, quantity: 2}
]

Enum.map(
  to_shop,
  fn ingredient ->
    changeset = CartIngredient.changeset(%CartIngredient{}, ingredient)
    Repo.insert!(changeset)
  end
)

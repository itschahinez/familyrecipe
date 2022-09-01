require "open-uri"

Recipe.destroy_all
User.destroy_all
Ingredient.destroy_all
Circle.destroy_all

puts "Creating seeds"

puts "Creating users"

cyril = User.create!(first_name: "Cyril", email: "cyril@gourmand.fr", password: 'secret')
mercotte = User.create!(first_name: "Mercotte", email: "mercotte@gourmand.fr", password: 'secret')
jojo = User.create!(first_name: "Jonathan", email: "jonathan@coco.fr", password: 'secret')


puts "Users done"

eggplant_parmesan = Recipe.create!(
  name: 'Eggplant Parmesan',
  description: 'Place eggplant slices in a large bowl in layers, sprinkling each layer with salt. Let stand for 30 minutes to drain. Rinse and dry on paper towels.
  Heat olive oil in a large skillet over medium heat. Whisk eggs with water and flour until smooth. Dip eggplant slices in batter and fry in the hot oil until golden brown, working in batches of 2 to 3 slices at a time.
  Mix seasoned bread crumbs with Parmesan cheese in a bowl. Place 1/4 of the eggplant slices into a slow cooker and top with 1/4 of the crumbs, 1/4 of the marinara sauce, and 1/4 of the mozzarella cheese. Repeat layers three more times.',
  category: 1,
  creator_id: cyril.id,
  preptime_hour: 5,
  preptime_mn: 30,
  prep_time: 330,
  photo: open("http://res.cloudinary.com/chahinezh/image/upload/v1662027214/sflkslsezu2a9tun3ozu.jpg")
)

puts "eggplant recipe created"

eggplant = Ingredient.create!(name: 'eggplant', unit: '')
parmesan = Ingredient.create!(name: 'parmesan', unit: 'gr')
tomato = Ingredient.create!(name: 'tomato', unit: '')
egg = Ingredient.create!(name: 'egg', unit: '')
puts "eggplantparm ingredients created"

RecipeIngredient.create!(ingredient: eggplant, recipe: eggplant_parmesan, quantity: 1)
RecipeIngredient.create!(ingredient: parmesan, recipe: eggplant_parmesan, quantity: 100)
RecipeIngredient.create!(ingredient: tomato, recipe: eggplant_parmesan, quantity: 2)
RecipeIngredient.create!(ingredient: egg, recipe: eggplant_parmesan, quantity: 2)

puts "Eggplant parmesan done"

chocolate_mousse = Recipe.create!(
  name: 'Chocolate cream',
  description: 'Mix mascarpone cheese, whipping cream, and vanilla extract in a bowl.
  Melt chocolate chips in the top of a double boiler over simmering water, stirring frequently and scraping down the sides with a rubber spatula to avoid scorching.
  Fold melted chocolate into the mascarpone cheese mixture.
  Refrigerate until set, 1 to 2 hours.',
  category: 2,
  creator_id: mercotte.id,
  preptime_hour: 1,
  preptime_mn: 15,
  prep_time: 75
)

mascarpone = Ingredient.create!(name: 'mascarpone', unit: 'gr')
whipping_cream = Ingredient.create!(name: 'whipping cream', unit: 'ml')
vanilla = Ingredient.create!(name: 'vanilla extract', unit: 'tsp')
chocolate_chips = Ingredient.create!(name: 'chocolate chips', unit: 'gr')

RecipeIngredient.create!(ingredient: mascarpone, recipe: chocolate_mousse, quantity: 200)
RecipeIngredient.create!(ingredient: whipping_cream, recipe: chocolate_mousse, quantity: 50)
RecipeIngredient.create!(ingredient: vanilla, recipe: chocolate_mousse, quantity: 1)
RecipeIngredient.create!(ingredient: chocolate_chips, recipe: chocolate_mousse, quantity: 150)

puts "Chocolate cream done"

tzatziki = Recipe.create!(
  name: 'Tzatziki',
  description: 'Combine yogurt, grated cucumber, lemon juice, olive oil, and garlic together in a large bowl. Add dill, salt, pepper, and lemon zest; mix until smooth.
  Pour into a serving dish, cover tightly, and refrigerate 8 hours before serving.',
  category: 0,
  creator_id: mercotte.id,
  preptime_hour: 0,
  preptime_mn: 15,
  prep_time: 15
)

cucumber = Ingredient.create!(name: 'cucumber', unit: '')
yoghurt = Ingredient.create!(name: 'yoghurt', unit: 'ml')
garlic = Ingredient.create!(name: 'garlic', unit: 'clove')
olive_oil = Ingredient.create!(name: 'olive oil', unit: 'ml')

RecipeIngredient.create!(ingredient: cucumber, recipe: tzatziki, quantity: 1)
RecipeIngredient.create!(ingredient: yoghurt, recipe: tzatziki, quantity: 1)
RecipeIngredient.create!(ingredient: garlic, recipe: tzatziki, quantity: 2)
RecipeIngredient.create!(ingredient: olive_oil, recipe: tzatziki, quantity: 3)

puts "Tzatziki done"

eggplant_pasta = Recipe.create!(
  name: 'Eggplant Pasta',
  description: '1. Heat 1 tablespoon oil in a skillet over medium heat. Add pancetta; cook until browned on the edges, about 5 minutes. Add eggplant and remaining 2 tablespoons olive oil; cook until eggplant is slightly softened, about 5 minutes.<br>
  2. Pour marinara sauce, tomatoes, and wine into the skillet. Add red pepper flakes, black pepper, garlic salt, sugar, and white pepper. Stir and cover. Let sauce simmer until flavors combine, about 20 minutes.<br>
  3. Bring a large pot of lightly salted water to a boil. Add penne and cook, stirring occasionally, until tender yet firm to the bite, about 11 minutes. Drain; mix with the sauce.',
  category: 1,
  creator_id: cyril.id,
  preptime_hour: 5,
  preptime_mn: 30,
  prep_time: 330
)

red_pepper = Ingredient.create!(name: 'red pepper', unit: '')
penne = Ingredient.create!(name: 'penne', unit: 'gr')

RecipeIngredient.create!(ingredient: tomato, recipe: eggplant_pasta, quantity: 2)
RecipeIngredient.create!(ingredient: red_pepper, recipe: eggplant_pasta, quantity: 2)
RecipeIngredient.create!(ingredient: eggplant, recipe: eggplant_pasta, quantity: 1)
RecipeIngredient.create!(ingredient: penne, recipe: eggplant_pasta, quantity: 250)

puts "Eggplant pasta done"

butter = Ingredient.create!(name: 'butter', unit: 'gr')
flour = Ingredient.create!(name: 'flour', unit: 'gr')
banana = Ingredient.create!(name: 'banana', unit: '')
vegetable_oil = Ingredient.create!(name: 'vegetable oil', unit: 'ml')

puts "created rest of ingredients"

circle1 = Circle.create!(name: "My Family")
circle2 = Circle.create!(name: "My Besties")

puts "created circles"

Participation.create!(circle: circle1, user: cyril)
Participation.create!(circle: circle2, user: cyril)
Participation.create!(circle: circle2, user: mercotte)

puts "created participations"

CircleRecipe.create!(circle: circle1, recipe: eggplant_parmesan)
CircleRecipe.create!(circle: circle1, recipe: eggplant_pasta)
CircleRecipe.create!(circle: circle1, recipe: chocolate_mousse)
CircleRecipe.create!(circle: circle1, recipe: tzatziki)
CircleRecipe.create!(circle: circle2, recipe: eggplant_parmesan)
puts "created circle recipes"

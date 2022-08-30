Recipe.destroy_all
User.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all

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
  category: 'main',
  creator_id: cyril.id,
  prep_time: 330
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
  category: 'dessert',
  creator_id: mercotte.id,
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
  category: 'starter',
  creator_id: mercotte.id,
  prep_time: 15
)

cucumber = Ingredient.create!(name: 'cucumber', unit: '')
yoghurt = Ingredient.create!(name: 'yoghurt', unit: 'cup')
garlic = Ingredient.create!(name: 'garlic', unit: 'clove')
olive_oil = Ingredient.create!(name: 'olive oil', unit: 'tbsp')

RecipeIngredient.create!(ingredient: cucumber, recipe: tzatziki, quantity: 1)
RecipeIngredient.create!(ingredient: yoghurt, recipe: tzatziki, quantity: 1)
RecipeIngredient.create!(ingredient: garlic, recipe: tzatziki, quantity: 2)
RecipeIngredient.create!(ingredient: olive_oil, recipe: tzatziki, quantity: 3)

puts "Tzatziki done"

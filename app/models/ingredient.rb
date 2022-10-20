class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true

  def name_and_unit
    unit.blank? ? name : "#{name} (#{unit})"
  end

  def self.autocomplete_ingredients(query, logged_user)
    user = User.find(logged_user.id)
    my_recipe_ingredients_ids = user.recipes.map { |recipe| recipe.ingredients.map(&:id) }.flatten!
    my_recipe_ingredients = Ingredient.where(id: my_recipe_ingredients_ids).where("name ilike ?", "#{query}%")
    my_recipe_ingredients_names = my_recipe_ingredients.map(&:name)

    my_circles_ingredients_ids = user.circles.map { |circle| circle.recipes.map { |recipe| recipe.ingredients.map(&:id) }}.flatten!
    my_circles_ingredients = Ingredient.where(id: my_circles_ingredients_ids).where("name ilike ?", "#{query}%")
    my_circles_ingredients_names = my_circles_ingredients.map(&:name)

    [my_recipe_ingredients_names, my_circles_ingredients_names].flatten.uniq
  end
end

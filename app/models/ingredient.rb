class Ingredient < ApplicationRecord
  has_many :recipes, through: :recipe_ingredients
  has_many :recipe_ingredients

  validates :name, :unit, presence: true, length: { maximum: 4 }
end

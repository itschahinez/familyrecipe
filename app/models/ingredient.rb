class Ingredient < ApplicationRecord
  has_many :recipes, through: :recipe_ingredients
  has_many :recipe_ingredients

  validates :name, presence: true
  validates :unit, length: { maximum: 5 }
end

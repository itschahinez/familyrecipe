class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true
  validates :unit, length: { maximum: 5 }


  def name_and_unit
    unit.blank? ? name : "#{name} (#{unit})"
  end
end

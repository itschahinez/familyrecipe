class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :quantity, presence: true

  accepts_nested_attributes_for :ingredient
end

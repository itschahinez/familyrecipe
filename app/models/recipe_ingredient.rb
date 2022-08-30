class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe, dependent: :destroy

  validates :quantity, presence: true
end

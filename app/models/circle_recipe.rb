class CircleRecipe < ApplicationRecord
  belongs_to :circle
  belongs_to :recipe, dependent: :destroy
end

class CircleRecipe < ApplicationRecord
  belongs_to :circle
  belongs_to :recipe
  has_many :users
end

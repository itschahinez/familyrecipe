class Circle < ApplicationRecord
  has_many :circle_recipes
  has_many :recipes, through: :circle_recipes
  has_many :participations
  has_many :users, through: :users

  validates :name, presence: true, length: { maximum: 15 }
end

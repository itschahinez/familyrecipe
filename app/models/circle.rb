class Circle < ApplicationRecord
  has_many :circle_recipes
  has_many :recipes, through: :circle_recipes
  has_many :participations
  has_many :users, through: :participations

  accepts_nested_attributes_for :participations, reject_if: :all_blank, allow_destroy: true, update_only: true
  validates :name, presence: true, length: { maximum: 15 }
end

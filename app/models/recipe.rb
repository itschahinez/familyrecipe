class Recipe < ApplicationRecord
  belongs_to :creator, foreign_key: :creator_id, class_name: 'User', dependent: :destroy
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :circle_recipes
  has_many :circles, through: :circle_recipes
  has_many :comments
  has_many :users, through: :comments

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :prep_time, presence: true
  validates :category, inclusion: { in: %w[starter main dessert] }
  validates :prep_time, numericality: { only_integer: true }
  validates :name, uniqueness: { scope: :creator }
end

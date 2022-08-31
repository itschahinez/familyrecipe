class Recipe < ApplicationRecord
  has_one_attached :photo
  enum category: { entree: 0, main: 1, dessert: 2 }

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
  validates :preptime_hour, presence: true
  validates :preptime_hour, presence: true
  validates :preptime_mn, presence: true
  # validates :category, inclusion: { in: category.keys }
  validates :prep_time, numericality: { only_integer: true }
  validates :name, uniqueness: { scope: :creator }

  accepts_nested_attributes_for :ingredients
end

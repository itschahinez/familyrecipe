class Recipe < ApplicationRecord
  include PgSearch::Model

  has_one_attached :photo

  belongs_to :creator, foreign_key: :creator_id, class_name: 'User'
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
  validates :preptime_mn, presence: true
  # validates :category, inclusion: { in: category.keys }
  validates :prep_time, numericality: { only_integer: true }
  validates :name, uniqueness: { scope: :creator }


  accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true
  enum category: { entree: 0, main: 1, dessert: 2 }

  accepts_nested_attributes_for :recipe_ingredients

  pg_search_scope :global_search,
  against: [ :name, :description ],
  associated_against: {
    ingredients: [:name]
  },
  using: {
    tsearch: { prefix: true }
  }
end

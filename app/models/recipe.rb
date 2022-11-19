# require "pry-byebug"
class Recipe < ApplicationRecord

  require 'rest-client'
  require 'open-uri'
  APIKEY = ENV["SPOON_API"]

  include PgSearch::Model

  has_one_attached :photo

  belongs_to :creator, foreign_key: :creator_id, class_name: 'User', optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :circle_recipes, dependent: :destroy
  has_many :circles, through: :circle_recipes
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :preptime_hour, presence: true
  validates :preptime_mn, presence: true
  # validates :category, inclusion: { in: category.keys }
  validates :prep_time, numericality: { only_integer: true }
  # validates :name, uniqueness: { scope: :creator }


  accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true
  # enum category: { entree: 0, main: 1, dessert: 2 }

  accepts_nested_attributes_for :recipe_ingredients
  accepts_nested_attributes_for :circle_recipes

  after_commit :initialize_event, on: :create

  def initialize_event
    Event.create_event(self, 'create')
  end

  pg_search_scope :global_search,
  against: [ :name, :description, :category ],
  associated_against: {
    ingredients: [:name]
  }

  def self.create_all_from_api(query)
    search_by_ing_url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{APIKEY}&ingredients=#{query.gsub(","," ").split.join(",+")}&ignorePantry=true&ranking=1&limitLicense=true&number=10"
    JSON.parse(RestClient.get(search_by_ing_url, {accept: :json}).body).each do |suggestion|
      create_one_from_api(suggestion["id"], query)
    end
  end

  def self.create_one_from_api(suggestion_id, query)
    recipe_info_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/information?apiKey=#{APIKEY}"
    suggestion_detail = RestClient.get recipe_info_url, {accept: :json}
    suggestion_detail = JSON.parse(suggestion_detail.body)

    recipe_instructions_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/analyzedInstructions?apiKey=#{APIKEY}"
    suggestion_description = RestClient.get recipe_instructions_url, {accept: :json}
    suggestion_description = JSON.parse(suggestion_description.body)

    recipe_parameters = [suggestion_detail["title"], suggestion_detail["id"], suggestion_detail["readyInMinutes"], suggestion_detail["dishTypes"], !suggestion_description.empty?, suggestion_detail["image"]]
    if recipe_parameters.all?
      steps = suggestion_description.first["steps"].map! { |instructions| instructions["step"] }
      description = steps.join(" ")

      recipe = self.new(
        name: suggestion_detail["title"],
        suggestion_id: suggestion_detail["id"],
        prep_time: suggestion_detail["readyInMinutes"],
        preptime_hour: suggestion_detail["readyInMinutes"]/60,
        preptime_mn: suggestion_detail["readyInMinutes"] % 60,
        category: suggestion_detail["dishTypes"].first,
        description: description,
        search: query
      )

      if recipe.save
        suggestion_picture_upload_response = Cloudinary::Uploader.upload(suggestion_detail["image"])
        suggestion_picture_url = suggestion_picture_upload_response["secure_url"]
        suggestion_picture = URI.open(suggestion_picture_url)
        recipe.photo.attach(io: suggestion_picture, filename: "#{suggestion_id}.jpg", content_type: "image/jpg")

        suggestion_detail["extendedIngredients"].each do |ingredient|
          i = Ingredient.find_or_create_by(name: ingredient["name"], unit: ingredient["unit"])
          RecipeIngredient.create(ingredient: i, quantity: ingredient["amount"].to_f, recipe: recipe)
        end
      end
    end
  end

  def self.search(query, logged_user)
    user = User.find(logged_user.id)
    my_recipes = user.recipes.global_search(query)
    my_circles = user.circles.map { |circle| circle.recipes.global_search(query) }
    [my_recipes, my_circles].flatten.uniq
  end

  def self.autocomplete_recipes_and_categories(query, logged_user)
    user = User.find(logged_user.id)
    my_recipes_ids = user.recipes.map(&:id)
    my_circle_recipes_ids = user.circles.map { |circle| circle.recipes.map(&:id) }.flatten!
    all_my_recipes_ids = [my_recipes_ids, my_circle_recipes_ids].flatten.uniq
    my_recipes_names = Recipe.get_info_by_search_criteria(all_my_recipes_ids, "name", query)
    my_recipe_categories_names = Recipe.get_info_by_search_criteria(all_my_recipes_ids, "category", query)
    [my_recipes_names, my_recipe_categories_names].flatten.uniq
  end

  private

  def self.get_info_by_search_criteria(recipes_ids, search_criteria, query)
    relevant_recipes = Recipe.where(id: recipes_ids).where("#{search_criteria} ilike ?", "#{query}%")
    relevant_recipes.map(&"#{search_criteria}".to_sym)
  end
end

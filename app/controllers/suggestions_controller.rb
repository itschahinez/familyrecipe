class SuggestionsController < ApplicationController
 require 'rest-client'
  APIKEY = 'apiKey=a030639b196a4b679ee09850e776128c'

  def index
    # ingredients = "apples,+flour,+sugar"
    # get data from the search option
    if params[:query].present?
      ingredients_array = params[:query].split
      # raise
      beginning_of_string = ingredients_array.first
      end_of_string = ingredients_array.drop(1).map { |ingredient| ",+#{ingredient}" }
      ingredients = beginning_of_string + end_of_string.join
      # raise
      @suggestions = creating_suggestions(ingredients)
      @suggestions.compact!
      @suggestions.map! { |suggestion| new_recipe_from_suggestion(suggestion) }
    end
  end

    # inject it into the search url of the API (Search by ingredients) - ignorePantry=& true, ranking=1
    # for each of the 10 results, get the name, picture and prep time (API call to get recipe info)

  def show
    suggestion_id = params[:id]
    @suggestion = single_suggestion_detail(suggestion_id)
    new_recipe_from_suggestion(@suggestion)

    # for the recipe we inject the ID into the search URL of the API (Get analyzed recipe ) for instructions
    # for the recipe we inject the ID ouinto the search URL of the API (get picture, ready in minutes, ingredient list, category) for instructions (change validations on category and maybe units)
    # change the appropriate fields
    # incorporate the save option, formulaire cache?
    # ingredients and quantities are in Search recipes by ingredients
  end

  private

  def creating_suggestions(ingredients)
    search_by_ing_url = "https://api.spoonacular.com/recipes/findByIngredients?#{APIKEY}&ingredients=#{ingredients}&ignorePantry=true&ranking=1&limitLicense=true&number=10"
    response = RestClient.get search_by_ing_url, {accept: :json}
    response = response.body

    @suggestions = JSON.parse(response)

    @suggestions.map! do |suggestion|
      single_suggestion_detail(suggestion["id"])
    end
  end

  def single_suggestion_detail(suggestion_id)
    recipe_info_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/information?#{APIKEY}"
    suggestion_detail = RestClient.get recipe_info_url, {accept: :json}
    suggestion_detail = JSON.parse(suggestion_detail.body)

    recipe_instructions_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/analyzedInstructions?#{APIKEY}"
    suggestion_description = RestClient.get recipe_instructions_url, {accept: :json}
    suggestion_description = JSON.parse(suggestion_description.body)

    recipe_parameters = [suggestion_detail["title"], suggestion_detail["id"], suggestion_detail["readyInMinutes"], suggestion_detail["dishTypes"], !suggestion_description.empty?]
    if recipe_parameters.all?
      steps = suggestion_description.first["steps"].map! { |instructions| instructions["step"] }
      description = steps.join(" ")

      ingredient_list = suggestion_detail["extendedIngredients"].map! do |ingredient|
        { name: ingredient["name"], unit: ingredient["unit"], quantity: ingredient["amount"] }
      end


      suggestion_params = {
        recipe_details: {
          name: suggestion_detail["title"],
          suggestion_id: suggestion_detail["id"],
          prep_time: suggestion_detail["readyInMinutes"],
          preptime_hour: suggestion_detail["readyInMinutes"]/60,
          preptime_mn: suggestion_detail["readyInMinutes"] % 60,
          category: suggestion_detail["dishTypes"].first,
          description: description,
        },
        recipe_photo: suggestion_detail["image"],
        ingredients: ingredient_list
      }
    end
  end

  def new_recipe_from_suggestion(suggestion)
    Recipe.new(suggestion[:recipe_details])
    suggestion_picture_upload_response = Cloudinary::Uploader.upload(suggestion[:recipe_photo])
    raise
    suggestion_picture_url = suggestion_picture_upload_response["secure_url"]
    suggestion_picture = URI.open(suggestion_picture_url)
    suggestion.photo.attach(io: suggestion_picture, filename: "#{suggestion[:recipe_details][:suggestion_id]}.jpg", content_type: "image/jpg")
  end

  # def ingredients_from_suggestion(suggestion)
  #   ingredient_list = suggestion["ingredients"]
  #   ingredient_list.each do |ingredient|
  #     ingredient = Ingredient.new(name: ingredient["name"], unit: ingredient["unit"])
  #     RecipeIngredient.new(ingredient: ingredient, quantity: ingredient["amount"])
  #   end
end

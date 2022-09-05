class SuggestionsController < ApplicationController
 require 'rest-client'
  @api_key = ''

  def index
    ingredients = "apples,+flour,+sugar"
    # get data from the search option
    @suggestions = creating_suggestions(ingredients)
    @suggestions.compact!

    # inject it into the search url of the API (Search by ingredients) - ignorePantry=& true, ranking=1
    # for each of the 10 results, get the name, picture and prep time (API call to get recipe info)

  end

  def show
    suggestion_id = params[:id]
    @suggestion = single_suggestion_detail(suggestion_id)
    raise
    # for the recipe we inject the ID into the search URL of the API (Get analyzed recipe ) for instructions
    # for the recipe we inject the ID ouinto the search URL of the API (get picture, ready in minutes, ingredient list, category) for instructions (change validations on category and maybe units)
    # change the appropriate fields
    # incorporate the save option, formulaire cache?
    # ingredients and quantities are in Search recipes by ingredients
  end

  private

  def set_suggestion

  end

  def creating_suggestions(ingredients)
    search_by_ing_url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=a261b74e2aa04d86b784a067acd66b6f&ingredients=#{ingredients}&ignorePantry=true&ranking=1&limitLicense=true&number=25"
    response = RestClient.get search_by_ing_url, {accept: :json}
    response = response.body

    @suggestions = JSON.parse(response)

    @suggestions.map! do |suggestion|
      single_suggestion_detail(suggestion["id"])
    end
  end

  def single_suggestion_detail(suggestion_id)
    recipe_info_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/information?apiKey=a261b74e2aa04d86b784a067acd66b6f"
    suggestion_detail = RestClient.get recipe_info_url, {accept: :json}
    suggestion_detail = JSON.parse(suggestion_detail.body)

    recipe_instructions_url = "https://api.spoonacular.com/recipes/#{suggestion_id}/analyzedInstructions?apiKey=a261b74e2aa04d86b784a067acd66b6f"
    suggestion_description = RestClient.get recipe_instructions_url, {accept: :json}
    suggestion_description = JSON.parse(suggestion_description.body)


    recipe_parameters = [suggestion_detail["title"], suggestion_detail["id"], suggestion_detail["readyInMinutes"], suggestion_detail["dishTypes"], !suggestion_description.empty?]
    if recipe_parameters.all?
      steps = suggestion_description.first["steps"].map! { |instructions| instructions["step"] }
      description = steps.join(" ")

      recipe = Recipe.new(name: suggestion_detail["title"],
        suggestion_id: suggestion_detail["id"],
        prep_time: suggestion_detail["readyInMinutes"],
        preptime_hour: suggestion_detail["readyInMinutes"]/60,
        preptime_mn: suggestion_detail["readyInMinutes"] % 60,
        category: suggestion_detail["dishTypes"].first,
        description: description
      )
    end
  end
end

class SuggestionsController < ApplicationController
 require 'rest-client'
  @api_key = ''

  def index

    # get data from the search option
    search_by_ing_url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=a261b74e2aa04d86b784a067acd66b6f&ingredients=apples,+flour,+sugar&ignorePantry=true&ranking=1"
    response = RestClient.get search_by_ing_url, {accept: :json}
    response = response.body

    @suggestions = JSON.parse(response)

    @suggestions.map! do |suggestion|
      recipe_info_url = "https://api.spoonacular.com/recipes/#{suggestion["id"]}/information?apiKey=a261b74e2aa04d86b784a067acd66b6f"
      suggestion_detail = RestClient.get recipe_info_url, {accept: :json}
      suggestion_detail = JSON.parse(suggestion_detail.body)
      raise
      recipe_instructions_url = "https://api.spoonacular.com/recipes/#{suggestion["id"]}/analyzedInstructions?apiKey=a261b74e2aa04d86b784a067acd66b6f"

      suggestion_description = RestClient.get recipe_instructions_url, {accept: :json}
      suggestion_description = JSON.parse(suggestion_description.body)
      raise

      recipe = Recipe.new(name: suggestion["title"],
        suggestion_id: suggestion["id"],
        prep_time: suggestion_detail["readyInMinutes"],
        preptime_hour: suggestion_detail["readyInMinutes"]/60,
        preptime_mn: suggestion_detail["readyInMinutes"] % 60,
        category: suggestion_detail["dishTypes"].first,
        description:
      )
    end

    @suggestions
    # inject it into the search url of the API (Search by ingredients) - ignorePantry=& true, ranking=1
    # for each of the 10 results, get the name, picture and prep time (API call to get recipe info)

  end

  def show

    # for the recipe we inject the ID into the search URL of the API (Get analyzed recipe ) for instructions
    # for the recipe we inject the ID ouinto the search URL of the API (get picture, ready in minutes, ingredient list, category) for instructions (change validations on category and maybe units)
    # change the appropriate fields
    # incorporate the save option, formulaire cache?
    # ingredients and quantities are in Search recipes by ingredients
  end
end

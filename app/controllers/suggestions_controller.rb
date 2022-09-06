class SuggestionsController < ApplicationController
   def index
     # ingredients = "apples,+flour,+sugar"
     # get data from the search option

    session[:search] = params[:query] unless params[:query].blank?
    if !session[:search].blank?
      if Recipe.where(search: session[:search]).empty?
        Recipe.create_all_from_api(session[:search])
      end
      @suggestions = Recipe.where(search: session[:search])
    end
   end
     # inject it into the search url opf the API (Search by ingredients) - ignorePantry=& true, ranking=1
     # for each of the 10 results, get the name, picture and prep time (API call to get recipe info)

   def show
     @recipe = Recipe.find(params[:id])
   end

end

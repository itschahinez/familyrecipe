class RecipesController < ApplicationController
  def index
    @my_recipes = current_user.recipes.sort_by(&:name)
    @my_circles = current_user.circles.sort_by(&:name)
    @results = Recipe.search(params[:query], current_user) if params[:query].present?
  end

  def show
    @recipe = Recipe.find(params[:id])
    @circle_recipe = CircleRecipe.new
    @comment = Comment.new
    all_friends = current_user.circles.map(&:users).flatten.uniq
    @all_friends_comments = Comment.where(user: all_friends).where(recipe: @recipe)
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
    @ingredient = @recipe_ingredients.build_ingredient
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.creator = current_user
    @recipe.prep_time = 0
    if !@recipe.preptime_hour.nil? && !@recipe.preptime_mn.nil?
      @recipe.prep_time = (@recipe.preptime_hour * 60) + @recipe.preptime_mn
    end
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/new", status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    # @recipe.update(recipe_params)
    if @recipe.creator_id.nil?  #Don't remove: important to add a new recipe from suggestions
      @recipe.update(creator_id: current_user.id)
      flash[:notice] = "#{@recipe.name} has been added to your recipes"
    end
    redirect_to suggestions_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, status: :see_other
  end

  def autocomplete
    recipes_and_categories_names = Recipe.autocomplete_recipes_and_categories(params[:q], current_user)
    ingredients_names = Ingredient.autocomplete_ingredients(params[:q], current_user)
    @search_results = [recipes_and_categories_names, ingredients_names].flatten.uniq
    render partial: 'autocomplete', formats: :html
  end

  def assign_creator
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name, :description, :category, :prep_time, :preptime_hour, :preptime_mn, :photo, :creator_id,
      recipe_ingredients_attributes: [:quantity, :id, :ingredient_id, :_destroy]
    )
  end
end

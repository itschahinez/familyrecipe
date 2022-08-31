class RecipesController < ApplicationController
  def index
    if params[:query].present?
      # @all_recipes = []
      my_recipes = current_user.recipes.global_search(params[:query])
      # my_circles = current_user.circles.map { |circle| circle.recipes.global_search(params[:query]) }
      # @all_recipes.push(my_recipes)
      # @all_recipes.push(my_circles)
    else
      @my_recipes = current_user.recipes
      @my_circles = current_user.circles
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe.prep_time = (@recipe.preptime_hour * 60) + @recipe.preptime_mn
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/new", status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipes_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name, :description, :category, :prep_time, :preptime_hour, :preptime_mn, :photo,
      recipe_ingredients_attributes: [:quantity, :id, :ingredient_id]
    )
  end
end

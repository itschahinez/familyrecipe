class RecipesController < ApplicationController
  def index
    @my_recipes = current_user.recipes
    @my_circles = current_user.circles
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.creator = current_user
    @recipe.prep_time = @recipe.preptime_hour * 60 + @recipe.preptime_mn
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/new", status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :category, :prep_time, :preptime_hour, :preptime_mn, :photo)
  end
end

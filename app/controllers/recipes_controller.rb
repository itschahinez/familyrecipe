class RecipesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    @recipe_ingredients = @ingredient.recipe_ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.creator = current_user
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
    params.require(:recipe).permit(
      :name, :description, :category, :prep_time, :photo,
      ingredients_attributes: [:name, :unit, :id,
      recipe_ingredients_attributes: [:quantity, :id]],
    )
  end
end

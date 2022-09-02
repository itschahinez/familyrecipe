class CircleRecipesController < ApplicationController
  def new
  end

  def create
    # @recipe = Recipe.find(params[:id])
    @circle_recipe = CircleRecipe.new(circle_recipe_params)
    if @circle_recipe.save
      raise
      redirect_to recipe_path(@recipe)
    else
      render "recipes/#{@recipe.id}", status: :unprocessable_entity
      raise
    end
  end

  def destroy
  end

  def circle_recipe_params
    params.require(:circle_recipe).permit(:circle_id, :recipe_id)
  end
end

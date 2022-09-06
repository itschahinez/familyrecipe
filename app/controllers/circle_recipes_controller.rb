class CircleRecipesController < ApplicationController
  def new
  end

  def create
    @circle_recipe = CircleRecipe.new(circle_recipe_params)
    @recipe = @circle_recipe.recipe
    if @circle_recipe.save
      redirect_to circle_path(@circle_recipe.circle.id)
      flash[:alert] = "#{@recipe.name} has been added to #{@circle_recipe.circle.name}"
    else
      render "recipes/#{@recipe.id}", status: :unprocessable_entity
      flash[:alert] = "#{@recipe.name} can't be added to #{@circle_recipe.circle.name}"
    end
  end

  def destroy
    @circle = Circle.find(params[:id])
    @recipe = Recipe.find(params[:recipe])
    @circle_recipe = CircleRecipe.find_by(circle: @circle, recipe: @recipe)
    @circle_recipe.destroy
    redirect_to @circle, status: :see_other
  end

  def circle_recipe_params
    params.require(:circle_recipe).permit(:circle_id, :recipe_id)
  end
end

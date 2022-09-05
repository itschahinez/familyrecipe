class CommentsController < ApplicationController
  before_action :set_recipe, only: %i[new create]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe = @recipe
    @comment.user = current_user
    if @comment.save
      redirect_to recipe_path(@recipe)
    else
      @circle_recipe = CircleRecipe.new
      render "recipes/show"
    end
  end

  # def new
  #   @recipe = recipe.find(params[:recipe_id])
  #   @comment = Comment.new
  # end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to recipe_path(@comment.recipe), status: :see_other
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

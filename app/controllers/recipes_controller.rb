class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @my_recipes = current_user.recipes.sort_by(&:name)
      @my_circles = current_user.circles.sort_by(&:name)
      @results = []
      my_recipes = current_user.recipes.global_search(params[:query])
      my_circles = current_user.circles.map { |circle| circle.recipes.global_search(params[:query]) }
      @results.push(my_recipes)
      @results.push(my_circles)
      @results.flatten!.uniq!
    else
      @my_recipes = current_user.recipes.sort_by(&:name)
      @my_circles = current_user.circles.sort_by(&:name)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @circle_recipe = CircleRecipe.new
    @comment = Comment.new

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
      flash[:alert] = "#{@recipe.name} has been added to your recipes"
      Event.new(description: "#{@recipe.name} has been added to your recipes")
    end
    redirect_to suggestions_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, status: :see_other

    # @comment = Comment.find(params[:id])
    # @comment.destroy
    # redirect_to restaurant_path(@comment.recipe), status: :see_other
  end

  def autocomplete
    my_recipes = current_user.recipes.where("name ilike ?", "#{params[:q]}%")
    my_recipes_names = my_recipes.map(&:name)

    my_circle_recipes_ids = current_user.circles.map { |circle| circle.recipes.map(&:id) }.flatten!
    my_circle_recipes = Recipe.where(id: my_circle_recipes_ids).where("name ilike ?", "#{params[:q]}%")
    my_circle_recipes_names = my_circle_recipes.map(&:name)

    my_recipe_ingredients_ids = current_user.recipes.map { |recipe| recipe.ingredients.map(&:id) }.flatten!
    my_recipe_ingredients = Ingredient.where(id: my_recipe_ingredients_ids).where("name ilike ?", "#{params[:q]}%")
    my_recipe_ingredients_names = my_recipe_ingredients.map(&:name)

    my_recipes_ids = current_user.recipes.map(&:id)
    all_my_recipes_ids = [my_recipes_ids, my_circle_recipes_ids].flatten.uniq
    my_recipe_categories = Recipe.where(id: all_my_recipes_ids).where("category ilike ?", "#{params[:q]}%")
    my_recipe_categories_names = my_recipe_categories.map(&:category)

    @search_results = [my_recipes_names, my_circle_recipes_names, my_recipe_ingredients_names, my_recipe_categories_names].flatten.uniq
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

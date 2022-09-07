class ChangeQuantityInRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe_ingredients, :quantity, :float
  end
end

class ChangeCategoryInRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :category, :string
  end
end

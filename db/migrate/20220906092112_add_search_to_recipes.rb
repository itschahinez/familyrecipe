class AddSearchToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :search, :string
  end
end

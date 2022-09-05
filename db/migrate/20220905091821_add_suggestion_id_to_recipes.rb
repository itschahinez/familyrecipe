class AddSuggestionIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :suggestion_id, :integer
  end
end

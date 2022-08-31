class ChangePrepTimeColumnInRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :prep_time, :integer
    add_column :recipes, :preptime_hour, :integer
    add_column :recipes, :preptime_mn, :integer
    add_column :recipes, :prep_time, :integer
  end
end

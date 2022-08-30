class CreateCircleRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :circle_recipes do |t|
      t.references :circle, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end

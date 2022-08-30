class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.string :category
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.integer :prep_time

      t.timestamps
    end
  end
end

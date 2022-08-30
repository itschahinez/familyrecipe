class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :circle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

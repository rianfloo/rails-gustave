class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.references :user, foreign_key: true
      t.references :dish, foreign_key: true
      t.references :wine, foreign_key: true

      t.timestamps
    end
  end
end

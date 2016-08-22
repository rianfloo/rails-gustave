class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :photo_url

      t.timestamps
    end
  end
end

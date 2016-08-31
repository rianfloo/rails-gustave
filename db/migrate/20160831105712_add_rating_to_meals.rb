class AddRatingToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :rating, :integer
  end
end

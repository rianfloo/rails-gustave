class CreateWines < ActiveRecord::Migration[5.0]
  def change
    create_table :wines do |t|
      t.integer :millesime
      t.string :color
      t.string :region
      t.string :appelation
      t.string :grape
      t.integer :price

      t.timestamps
    end
  end
end

class CreateWines < ActiveRecord::Migration[5.0]
  def change
    create_table :wines do |t|
      t.string :nom_vin
      t.string :type_vin
      t.integer :id_type_vin
      t.string :wine_color
      t.string :nom_region
      t.string :nom_pays

      t.timestamps
    end
  end
end

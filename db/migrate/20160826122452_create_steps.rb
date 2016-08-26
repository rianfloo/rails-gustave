class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :response

      t.timestamps
    end
  end
end

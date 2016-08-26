class AddItemToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_pic, :string
    add_column :users, :uniq_facebook, :string
  end
end

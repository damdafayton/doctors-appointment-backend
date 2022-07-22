class AddColumnstoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_name, :string, null: false, unique: true
    add_column :users, :email, :string, null: false
  end
end

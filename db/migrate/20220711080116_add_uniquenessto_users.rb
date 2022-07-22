class AddUniquenesstoUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_name, :string, null: false
    add_index :users, :user_name, unique: true
  end
end

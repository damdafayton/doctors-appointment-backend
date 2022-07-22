class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name, null: false
      t.string :photo, null: false
      t.string :bio, null: false
      t.string :profession, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end

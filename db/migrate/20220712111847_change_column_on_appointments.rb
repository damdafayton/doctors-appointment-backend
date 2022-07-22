class ChangeColumnOnAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :date, :datetime, :null => false
  end
end

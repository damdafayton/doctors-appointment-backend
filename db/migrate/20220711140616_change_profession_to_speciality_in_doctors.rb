class ChangeProfessionToSpecialityInDoctors < ActiveRecord::Migration[7.0]
  def change
    rename_column :doctors, :profession, :speciality
  end
end

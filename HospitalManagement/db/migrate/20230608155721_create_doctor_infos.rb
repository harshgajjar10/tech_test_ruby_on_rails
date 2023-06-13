class CreateDoctorInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_infos do |t|
      t.string :specialities
      t.string :doctor_type
      t.integer :user_id

      t.timestamps
    end
  end
end

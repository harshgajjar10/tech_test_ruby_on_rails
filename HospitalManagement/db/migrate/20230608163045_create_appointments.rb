class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :doctor_id
      t.date :appointment_date
      t.datetime :start_at
      t.datetime :end_at
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end

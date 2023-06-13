class CreateDoctorTimings < ActiveRecord::Migration[7.0]
  def change
    create_table :doctor_timings do |t|
      t.integer :weekday
      t.time :start_time
      t.time :end_time
      t.integer :doctor_info_id

      t.timestamps
    end
  end
end

class DoctorInfo < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :doctor_timings, dependent: :destroy

  accepts_nested_attributes_for :doctor_timings, allow_destroy: true

  def available_time_slots(appointment_date)
    weekday = appointment_date.to_date.wday
    doctor_timing = self.doctor_timings.find_by(weekday: weekday)
    if doctor_timing.present?
      time_slots = (doctor_timing.start_time.to_i ... doctor_timing.end_time.to_i).step(1.hour).to_a.map do |t|
        "#{Time.at(t).strftime('%H:%M')} - #{(Time.at(t) + 1.hour).strftime('%H:%M')}"
      end
    end  
  end
end

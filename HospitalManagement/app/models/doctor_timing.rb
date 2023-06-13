class DoctorTiming < ApplicationRecord
  # associations
  belongs_to :doctor_info

  # validations
  validates :weekday, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time, message: "End Time can't be same or lesser than Start Time" }


  def selected_slot_valid?(appointment_date, start_at, end_at)
    return false unless DateTime.parse("#{appointment_date} + #{self.start_time.strftime('%H:%M')} +0530") <= start_at
    return false unless DateTime.parse("#{appointment_date} + #{self.start_time.strftime('%H:%M')} +0530") <= end_at
    return false unless DateTime.parse("#{appointment_date} + #{self.end_time.strftime('%H:%M')} +0530") >= start_at
    return false unless DateTime.parse("#{appointment_date} + #{self.end_time.strftime('%H:%M')} +0530") >= end_at
    true
  end
end

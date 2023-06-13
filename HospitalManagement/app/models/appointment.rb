class Appointment < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :doctor, class_name: "User"

  # enums
  enum :status, [ :pending, :accepted, :rejected ]

  # validations
  validates :appointment_date, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :appointment_date, comparison: { greater_than_or_equal_to: Date.today, less_than_or_equal_to: Date.current + 7.days, message: I18n.t('appointment.seven_days_prior_only', upto_date: (Date.current + 7.days).strftime("%d/%m/%Y")) }, allow_blank: false, if: :appointment_date
  validates :start_at, comparison: { greater_than: DateTime.now }, allow_blank: false, if: :start_at
  validates :end_at, comparison: { greater_than: :start_at ,message: I18n.t('appointment.end_time_smaller') }, allow_blank: false, if: :end_at
  validate :doctor_availability, if: :new_record?
  validate :user_has_appointment_in_selecting_slot, if: :new_record?
  validate :slot_must_be_one_hour_only, if: :new_record?
  validate :timing_must_be_as_doctor_availability, if: :new_record?

  # callbacks
  before_validation :convert_timing_for_selected_date

  def doctor_availability
    doctor_appointments = Appointment.where(doctor_id: self.doctor_id, appointment_date: self.appointment_date)
    errors.add(:base, I18n.t('appointment.doctor_unavailable')) if doctor_appointments.where('start_at < ? AND end_at > ?', self.end_at, self.start_at).present?
  end

  def user_has_appointment_in_selecting_slot
    user_appointments = Appointment.where(user_id: self.user_id, appointment_date: self.appointment_date)
    errors.add(:base, I18n.t('appointment.user_unavailable')) if user_appointments.where('start_at < ? AND end_at > ?', self.end_at, self.start_at).present?
  end

  def timing_must_be_as_doctor_availability
    doctor = User.with_role(:doctor).find_by(id: self.doctor_id)
    doctor_timing = doctor&.doctor_info&.doctor_timings.find_by(weekday: self.appointment_date&.wday)
    if doctor_timing.present? && self.start_at.present? && self.end_at.present?
      errors.add(:base, "Invalid slot choosen") unless doctor_timing.selected_slot_valid?(self.appointment_date, self.start_at, self.end_at)
    else
      errors.add(:base, I18n.t('appointment.doctor_not_available'))
    end
  end

  def slot_must_be_one_hour_only
    if self.start_at.present? && self.end_at.present?
      errors.add(:base, I18n.t('appointment.slot_must_be_hour')) unless self.end_at == self.start_at + 1.hour
    else
      errors.add(:base, "Please select valid Time Slot")
    end
  end

  def convert_timing_for_selected_date
    self.start_at = DateTime.parse("#{self.appointment_date} #{self.start_at.strftime('%H:%M')} +0530")
    self.end_at = DateTime.parse("#{self.appointment_date} #{self.end_at.strftime('%H:%M')} +0530")
  end
end

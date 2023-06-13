class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Migrations         
  has_one :doctor_info
  has_many :user_appointments, class_name: "Appointment", foreign_key: "user_id"
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: "doctor_id"

  def appointments
    self.has_role?(:doctor) ? doctor_appointments : user_appointments
  end
end

module ApplicationHelper
  def doctor_signed_in?
    current_user.has_role?(:doctor)
  end

  def patient_signed_in?
    current_user.has_role?(:patient)
  end
end

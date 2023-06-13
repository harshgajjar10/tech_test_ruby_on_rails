class DoctorInfoPolicy
  attr_reader :user, :doctor_info

  def initialize(user, doctor_info)
    @user = user
    @doctor_info = doctor_info
  end

  def new?
    user.has_role?(:doctor)
  end

  def create?
    user.has_role?(:doctor)
  end

  def edit?
    user.has_role?(:doctor)
  end

  def update?
    user.has_role?(:doctor)
  end
end
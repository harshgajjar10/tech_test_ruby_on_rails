class AppointmentPolicy
  attr_reader :user, :appointment

  def initialize(user, appointment)
    @user = user
    @appointment = appointment
  end

  def index?
    user.has_role?(:doctor) || user.has_role?(:patient)
  end

  def new?
    user.has_role?(:patient)
  end

  def create?
    user.has_role?(:patient)
  end

  def update_status?
    user.has_role?(:doctor)
  end
end

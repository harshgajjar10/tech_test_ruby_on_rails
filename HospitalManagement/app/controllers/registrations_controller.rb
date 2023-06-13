class RegistrationsController < Devise::RegistrationsController
  after_action :assign_role, only:[:create]

  def assign_role
    role = Role.find_by(id: params[:user][:role_ids])
    current_user.add_role role.name
  end
end
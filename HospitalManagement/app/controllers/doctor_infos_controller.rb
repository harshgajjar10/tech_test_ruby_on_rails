class DoctorInfosController < ApplicationController
  before_action :find_doctor_info, only: [:edit, :update]

  def new
    @doctor_info = current_user.build_doctor_info
    authorize @doctor_info
  end

  def create
    @doctor_info = current_user.build_doctor_info(doctor_info_params)
    authorize @doctor_info
    if @doctor_info.save
      redirect_to root_path, notice: "Doctor Info Created Successfully"
    else
      render :new, alert: @doctor_info.errors.full_messages.join(', ')
    end
  end

  def edit
    authorize @doctor_info if @doctor_info.present?
  end

  def update
    authorize @doctor_info
    if @doctor_info.update(doctor_info_params)
      redirect_to root_path, notice: "Doctor Info Updated Successfully"
    else
      render :edit, alert: @doctor_info.errors.full_messages.join(', ')
    end
  end

  private

  def find_doctor_info
    @doctor_info = current_user.doctor_info
  end

  def doctor_info_params
    params.require(:doctor_info).permit(:specialities, :doctor_type, doctor_timings_attributes: [ :id, :weekday, :start_time, :end_time, :_destroy, ])
  end
end

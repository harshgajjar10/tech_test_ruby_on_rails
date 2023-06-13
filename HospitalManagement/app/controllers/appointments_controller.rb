class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [:update_status]

  def index
    if params[:history]
      @appointments = current_user.appointments.where('appointment_date < ?', Date.today).order(appointment_date: :desc)
    else
      @appointments = current_user.appointments.where('appointment_date >= ?', Date.today).order(appointment_date: :asc)
    end
    authorize @appointments
  end

  def new
    @appointment = current_user.appointments.build
    authorize @appointment
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    authorize @appointment
    if @appointment.save
      redirect_to root_path, notice: "Appointment Created Successfully"
    else
      flash[:alert] = @appointment.errors.full_messages.join(', ')
      render :new
    end
  end

  def get_time_slots
    doctor = User.with_role(:doctor).find_by(id: params[:doctor_id])
    time_slots = doctor.doctor_info.available_time_slots(params[:appointment_date]) if doctor&.doctor_info.present?
    respond_to do |format|
      format.js { render json: { time_slots: time_slots } }
    end
  end

  def update_status
    authorize @appointment
    @appointment.update(status: params[:status].to_i)
    redirect_to appointments_path
  end

  private

  def find_appointment
    @appointment = Appointment.find_by_id(params[:id])
  end

  def appointment_params
    params.permit(:id, :user_id, :doctor_id, :appointment_date, :start_at, :end_at, :status)
  end
end

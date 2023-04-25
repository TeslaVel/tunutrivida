class AppointmentsController < ApplicationController
  def index
    # @date = params[:date] ? Date.parse(params[:date]) : Date.today
    # @appointments = Appointment.where(date: @date.beginning_of_month..@date.end_of_month)
    # start_date = params.fetch(:start_date, Date.today).to_date

    start_date = params.fetch(:start_date, Date.today).to_date
    @appointments = Appointment.where(starts_at: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    # @appointments = Appointment.where(starts_at: @date.beginning_of_month.beginning_of_week..@date.end_of_month.end_of_week)
  end

  def new
    start_date = params.fetch(:start_date, Date.today).to_date
    @appointment = Appointment.new(starts_at: start_date, dietitian_id: current_user.id)
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to appointments_path(start_date: @appointment.starts_at), notice: 'Appointment was successfully created.'
    else
      redirect_to new_appointment_path(@appointment), notice: @appointment.errors.full_messages.join(". ") << "."
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :starts_at, :ends_at, :dietitian_id, :patient_id)
  end
end

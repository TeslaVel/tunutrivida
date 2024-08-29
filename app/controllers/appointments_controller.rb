# frozen_string_literal: true

# AppointmentsController
class AppointmentsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_appointment, only: %i[ show edit update destroy]

  def index
    # @appointments = Appointment.where(date: @date.beginning_of_month..@date.end_of_month)
    # start_date = params.fetch(:start_date, Date.today).to_date

    start_date = params.fetch(:start_date, Date.today).to_date

    @appointments = Appointment.where(start_date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).order(:start_date, time_start: :asc)

    @calendar_options = {
      calendar_type: params.fetch(:calendar_type, :week).to_sym,
      events: @appointments
    }
  end

  def show
    @event = OpenStruct.new(start_time: @appointment.start_date, title: @appointment.title)
  end

  def new
    @prevent_caching = true
    start_date = params.fetch(:start_date, Date.today).to_date
    @appointment = Appointment.new(start_date: start_date)
  end

  def edit
    @prevent_caching = true
    @appointment.persisted? || @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to appointments_path(start_date: @appointment.start_date), notice: 'Appointment was successfully created.'
    else
      redirect_to new_appointment_path(@appointment), notice: @appointment.errors.full_messages.join(". ") << "."
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path(start_date: @appointment.start_date), notice: 'Appointment was successfully updated.'
    else
      render :edit, notice: @appointment.errors.full_messages.join(". ") << "."
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params
      .require(:appointment)
      .permit(
        :start_date,
        :dietitian_id,
        :time_start,
        :time_end,
        :appointment_type,
        :status,
        :patient_id)
  end
end

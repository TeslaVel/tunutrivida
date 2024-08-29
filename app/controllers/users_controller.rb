# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_patient, only: %i[ show edit update destroy ]
  before_action :set_session, only: %i[show]

  include SessionConcern

  # GET /patients or /patients.json
  def index
    # GlobalEventsChannel.broadcast_to(nil, message: 'Hello, world111')
    # ActionCable.server.broadcast "clients_channel", message: 'Hello, world2'
    # ActionCable.server.broadcast("global_events", { user_id: current_user.id, message: 'Hello, world!'})
    @patients = current_user.patients.order(created_at: :desc).page(params[:page] || 1)
  end

  def filter
    srch = filter_params[:name_filter]
    gender_id = filter_params[:gender_id]

    plist = current_user.patients
    plist = plist.search_patients(srch.downcase) if srch.present?

    if gender_id.present? && gender_id != 'all'
      plist = plist.where(gender_id: gender_id.to_i)
    end

    # @patients = plist if srch.blank?
    @patients = plist.page(params[:page] || 1)

    respond_to do |format|
      # format.html { redirect_to patients_url }
      format.js { render :index, layout: false }
    end
  end

  # GET /patients/1 or /patients/1.json
  def show
    @indicatorsImc = resource_indicators_imc(4)
    @indicatorsDpc = resource_indicator_pdc(@patient.gender_id)
    @indicatorsIcc = resource_indicators_icc(@patient.gender_id)

    if @session.present?
      @diagnosisImc = resource_diagnosis(@indicatorsImc, @session.imc)
      @diagnosisDpc = resource_diagnosis(@indicatorsDpc, @session.waist)
      # raise  @session.waist
      @icc = resource_icc(@session&.waist, @session&.hip)
      @diagnosisIcc = resource_diagnosis(@indicatorsIcc, @icc)
    end
  end

  def session_qty
    # Override the method from SessionConcern to do nothing
  end

  # GET /patients/new
  def new
    @patient = User.new
    @genders = Gender.all
  end

  # GET /patients/1/edit
  def edit
    @genders = Gender.all
  end

  # POST /patients or /patients.json
  def create
    @patient = User.new(patient_params.merge(
      password: 'tunutrivida',
      password_confirmation: 'tunutrivida',
      dietitian_id: current_user.id,
      organization_id: current_user.organization_id
    ))

    if @patient.save
      redirect_to patient_path(@patient), notice: 'Patient was successfully created.'
    else
      redirect_to new_patient_path(@patient), notice: @patient.errors.full_messages.join(". ") << "."
    end
  end

  def create_from_instant
    instant = InstantSession.find(params[:id])

    @patient = User.create_patient_from_insant_session(
      current_user.id,
      patient_params.merge(
        password: 'tunutrivida',
        password_confirmation: 'tunutrivida',
        dietitian_id: current_user.id,
        organization_id: current_user.organization_id
      ),
      params[:id],
      params[:user][:package_id]
    )

    if @patient.present?
      InstantSession.find(params[:id]).destroy
      redirect_to patient_path(@patient), notice: 'Patient was successfully created.'
    else
      redirect_to instant_session_path(instant), alert: "Ha ocurrido um error al crear al paciente"
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patient_path(@patient), notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_patient
    @patient = User.find_by_id(params[:id])
    # @patient = User.find_by_slug(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:user)
          .permit(
            :first_name,
            :last_name,
            :date_of_birth,
            :gender_id,
            :bmr_factor_source,
            :image)
  end

  def filter_params
    params.permit(:name_filter, :indicator_type_id, :gender_id, :page)
  end

  def set_session
    @session = @patient.sessions.date_asc.last
  end
end

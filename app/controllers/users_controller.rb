class UsersController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]
  before_action :set_session, only: %i[show]

  # GET /patients or /patients.json
  def index
    # GlobalEventsChannel.broadcast_to(nil, message: 'Hello, world111')
    # ActionCable.server.broadcast "clients_channel", message: 'Hello, world2'
    # ActionCable.server.broadcast("global_events", { user_id: current_user.id, message: 'Hello, world!'})
    @patients = current_user.patients.order(created_at: :desc).page(params[:page] || 1)
  end

  def search
    srch = search_params[:search].downcase

    plist = current_user.patients
    @patients = plist.search_patients(srch) if srch.present? 
    @patients = plist if srch.blank?
    @patients = @patients.page(params[:page] || 1)

    respond_to do |format|
      format.html { redirect_to patients_url }
      format.js { render :index, layout: false }
    end
  end

  # GET /patients/1 or /patients/1.json
  def show
    @indicatorsImc = Indicator.where(indicator_types: 1, gender_id: 4)
    @indicatorsDpc = Indicator.where(indicator_types: 2, gender_id: @patient.gender_id)
    @indicatorsIcc = Indicator.where(indicator_types: 3, gender_id: @patient.gender_id)

    if @session.present?
      # @diagnosisImc = @indicatorsImc.find {|ind| @session.imc >= ind.value_min && @session.imc <= ind.value_max}
      @diagnosisImc = @indicatorsImc.where("value_min <= ? AND value_max >= ?", @session.imc, @session.imc).first

      # @diagnosisDpc = @indicatorsDpc.find {|ind| @session.waist >= ind.value_min && @session.waist < ind.value_max}
      @diagnosisDpc = @indicatorsDpc.where("value_min <= ? AND value_max > ?", @session.waist, @session.waist).first

      @icc = if @session.waist.blank? || @session.hip.blank?
               0
            else
              (@session.waist / @session.hip).round(2)
            end
      @diagnosisIcc = @indicatorsIcc.find { |ind| @icc > ind.value_min && @icc <= ind.value_max }
    end
    # @sessions = @patient.sessions.id_desc
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
    @patient = User.new(patient_params)

    if @patient.save
      redirect_to patient_path(@patient), notice: 'Patient was successfully created.'
    else
      redirect_to new_patient_path(@patient), notice: @patient.errors.full_messages.join(". ") << "."
    end
  end

  def create_from_instant
    @patient = User.create_patient_from_insant_session(
      current_user.id,
      patient_params,
      params[:id],
      params[:user][:package_id]
    )

    if @patient.persisted?
      redirect_to patient_path(@patient), notice: 'Patient was successfully created.'
    else
      redirect_to new_patient_path(@patient), notice: @patient.errors.full_messages.join(". ") << "."
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
              :gender_id)
              .merge(
                password: 'tunutrivida',
                password_confirmation: 'tunutrivida',
                dietitian_id: current_user.id,
                organization_id: current_user.organization_id
              )
    end

    def search_params
      params.permit(:search, :page)
    end

    def set_session
      @session = @patient.sessions.date_asc.last
    end
end

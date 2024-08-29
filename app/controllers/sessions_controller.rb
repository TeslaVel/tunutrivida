# frozen_string_literal: true

# SessionsController
class SessionsController < ApplicationController
  before_action :set_patient
  before_action :set_package
  before_action :set_session, except: %i[new create]
  # include JavascriptInclusion
  include SessionConcern

  # # GET /sessions/new
  def new
    if (@patient_package.sessions.count == session_qty) &&
        @patient_package.package.weeks > 0 && @patient_package.package.session_quantity > 0
      redirect_to patient_patient_package_path(@patient, @patient_package), notice: "All sessions was completed"
    end
    @session = @patient_package.sessions.build
    @activity_factors = ActivityFactor.all
  end

  def show
    @indicatorsImc = resource_indicators_imc(4)
    @indicatorsDpc = resource_indicator_pdc(@patient.gender_id)
    @diagnosisImc = resource_diagnosis(@indicatorsImc, @session.imc)
    @diagnosisDpc = resource_diagnosis(@indicatorsDpc, @session.waist)
    icc = resource_icc(@session&.waist, @session&.hip)
    @indicatorsIcc = resource_indicators_icc(@patient.gender_id)
    @diagnosisIcc = resource_diagnosis(@indicatorsIcc, icc)
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
    @activity_factors = ActivityFactor.all
  end

  # POST /sessions
  def create
    if @patient_package.sessions.count == session_qty &&
       @patient_package.package.weeks > 0 && @patient_package.package.session_quantity > 0
      redirect_to patient_patient_package_path(@patient,@patient_package), notice: "All sessions was completed"
      return
    end

    @session = @patient_package.sessions.build(session_params.merge(created_by_id: current_user.id))
    # @session.imc = (@session.weight / (@session.height * @session.height)).round(2)
    @session.dietitian = current_user
    @session.patient = @patient
    @session.date = Time.now

    return respond_to do |format|
      if @session.save
        format.html { redirect_to patient_patient_package_session_show_path(@patient,@session.patient_package,@session), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @gender }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session.errors.full_messages.join(". ") << "." }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    @session.imc = (@session.weight / (@session.height * @session.height)).round(2)
    if @session.update(session_params)
      notice = 'Session was successfully updated.'
    else
      notice = @session.errors.full_messages.join(". ") << "."
    end

    redirect_to patient_patient_package_session_show_path(@patient,@session.patient_package,@session), notice: notice
    return
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = User.find_by_id(params[:patient_id])
    # @patient = User.find_by_slug(params[:patient_id])
  end

  def set_package
    @patient_package = @patient.patient_packages.find(params[:patient_package_id])
  end

  def set_session
    @session = @patient_package.sessions.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(
      :date, :weight,
      :height,
      :waist,
      :hip,
      :high_abdomen,
      :low_abdomen,
      :ideal_weight,
      :body_grease,
      :visceral_grease,
      :muscle_mass,
      :bone_mass,
      :bmr,
      :metabolic_age,
      :water_percentage,
      :physical_complexion,
      :activity_factor_id
    )
  end
end

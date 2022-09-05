class InstantSessionsController < ApplicationController
  ## load cancan abilities
  before_action :set_instant_session, only: %i[ show edit update destroy ]

  # GET /instant_sessions or /instant_sessions.json
  def index
    @instant_sessions = InstantSession.all.page(params[:page] || 1)
  end

  # GET /instant_sessions/1 or /instant_sessions/1.json
  def show
    @indicatorsImc = Indicator.where(indicator_types: 1, gender_id: 4)
    @diagnosisImc = @indicatorsImc.find {|ind| @instant_session.imc >= ind.value_min && @instant_session.imc <= ind.value_max}

    @indicatorsDpc = Indicator.where(indicator_types: 2, gender_id: @instant_session.gender_id)
    @diagnosisDpc = @indicatorsDpc.find {|ind| @instant_session.waist >= ind.value_min && @instant_session.waist < ind.value_max}

    icc = (@instant_session.waist / @instant_session.hip).round(2)
    @indicatorsIcc = Indicator.where(indicator_types: 3, gender_id: @instant_session.gender_id)
    @diagnosisIcc = @indicatorsIcc.find { |ind| icc > ind.value_min && icc <= ind.value_max }
  end

  # GET /instant_sessions/new
  def new
    @instant_session = InstantSession.new
  end

  # GET /instant_sessions/1/edit
  def edit
  end

  # POST /instant_sessions or /instant_sessions.json
  def create
    @instant_session = InstantSession.new(instant_session_params.merge(created_by_id: current_user.id))

    respond_to do |format|
      if @instant_session.save
        format.html { redirect_to @instant_session, notice: "instant_session was successfully created." }
        format.json { render :show, status: :created, location: @instant_session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instant_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instant_sessions/1 or /instant_sessions/1.json
  def update
    respond_to do |format|
      if @instant_session.update(instant_session_params)
        format.html { redirect_to @instant_session, notice: "Discount was successfully updated." }
        format.json { render :show, status: :ok, location: @instant_session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instant_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instant_sessions/1 or /instant_sessions/1.json
  def destroy
    @instant_session.destroy
    respond_to do |format|
      format.html { redirect_to instant_sessions_url, notice: "discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instant_session
      @instant_session = InstantSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instant_session_params
      params.require(:instant_session).permit(
        :date, :weight,
        :height,
        :waist,
        :hip,
        :high_abdomen,
        :ideal_weight,
        :body_grease,
        :visceral_grease,
        :muscle_mass,
        :bone_mass,
        :bmr,
        :metabolic_age,
        :water_percentage,
        :physical_complexion,
        :activity_factor_id,
        :gender_id
     )
    end
end

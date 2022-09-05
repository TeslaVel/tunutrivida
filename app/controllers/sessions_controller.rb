class SessionsController < ApplicationController
  # before_action :get_patient_json, only: [:sessionsjson]
  # before_action :set_patient, except: [:sessionsjson]
  before_action :set_patient
  before_action :set_package
  before_action :set_session, except: [:new, :create]
  # include JavascriptInclusion

  # # GET /sessions/new
  def new
    if @patient_package.sessions.count == @patient_package.package.weeks && @patient_package.package.weeks > 0
      redirect_to patient_patient_package_path(@patient,@patient_package), notice: "All sessions was completed"
    end
    @session = @patient_package.sessions.build
    @activity_factors = ActivityFactor.all
  end

  
  def show
    @indicatorsImc = Indicator.where(indicator_types: 1, gender_id: 4)
    # @diagnosisImc = @indicatorsImc.find {|ind| @session.imc >= ind.value_min && @session.imc <= ind.value_max}
    @diagnosisImc = @indicatorsImc.where("value_min <= ? AND value_max >= ?", @session.imc, @session.imc).first


    @indicatorsDpc = Indicator.where(indicator_types: 2, gender_id: @patient.gender_id)
    # @diagnosisDpc = @indicatorsDpc.find {|ind| @session.waist >= ind.value_min && @session.waist < ind.value_max}
    @diagnosisDpc = @indicatorsDpc.where("value_min <= ? AND value_max > ?", @session.waist, @session.waist).first


    icc = if @session.waist.blank? || @session.hip.blank?
             0
          else
            (@session.waist / @session.hip).round(2)
          end
    @indicatorsIcc = Indicator.where(indicator_types: 3, gender_id: @patient.gender_id)
    @diagnosisIcc = @indicatorsIcc.find { |ind| icc > ind.value_min && icc <= ind.value_max }
    
    # sql = <<-SQL
    #   SELECT
    #     value_min,value_max,position
    #     FROM
    #       indicators i
    #     WHERE
    #     i.indicator_type_id = :type AND i.gender_id = :gender
    # SQL

    # @indicators_im =
    # ActiveRecord::Base.connection.execute(
    #   ActiveRecord::Base.send(:sanitize_sql_array, [sql, type: 1, gender: 4])
    # )
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
    @activity_factors = ActivityFactor.all
  end

  # # POST /sessions
  def create
    if @patient_package.sessions.count == @patient_package.package.weeks
      redirect_to patient_patient_package_path(@patient,@patient_package), notice: "All sessions was completed"
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

  # # PATCH/PUT /posts/1
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

  
  # def sessionsjson
  #   sessions = @patient.sessions.id_asc
  #   max_imc_value = sessions.maximum(:imc)
  #   sessions = sessions.last(10)
  #   imc_values = sessions.map(&:imc)
  #   days = sessions.map {|sess| sess.date.to_date.strftime('%d-%m-%Y') }

  #   render :json => {patient: @patient, imc_values: imc_values, days: days, max_imc_value: max_imc_value }
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find_by_slug(params[:patient_id])
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

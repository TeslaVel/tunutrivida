class PatientPackagesController < ApplicationController
 before_action :get_patient_json, only: [:sessionsjson, :packagesjson]
 before_action :get_patient_packages_json, only: [:sessionsjson]
 before_action :set_patient, except: [:sessionsjson, :packagesjson]
 before_action :set_patient_package, only: [:show]

  # GET /patients/:patient_id/patient_packages/:id
  def show
  end

  # GET /patients/:patient_id/patient_packages/new
  def new
    active = @patient.patient_packages.active.first

    if active && active.sessions.count < active.package.weeks
      redirect_to @patient, alert: 'Current Patient package is not completed.'
    end

    @patien_package = @patient.patient_packages.build
    @packages = Package.all
  end

  # POST /patients/:patient_id/patient_packages/create
  def create

    active = @patient.active_package

    if active && active.sessions.count < active.package.weeks
      redirect_to @patient, alert: 'Current Patient package is not completed.'
    end

    patient_package_params[:date] = patient_package_params[:date].to_date
    @patien_package = @patient.patient_packages.build(patient_package_params)
    @patien_package.dietitian = current_user
    @patien_package.status = :active

    if @patien_package.save
      redirect_to patient_package_show_path(@patient,@patien_package), success: 'Package was successfully created.'
    else
      render :new, error: @patien_package.errors.full_messages.join(". ") << "."
    end
  end

  # GET /patients/:patient_id/packages/:id/sessions/sessionsjson
  def sessionsjson
    sessions = @patient_packages.sessions.id_asc
    max_imc_value = sessions.maximum(:imc)
    sessions = sessions.last(10)
    imc_values = sessions.map(&:imc)
    days = sessions.map {|sess| sess.date.to_date.strftime('%d-%m-%Y') }

    render :json => {patient: @patient, imc_values: imc_values, days: days, max_imc_value: max_imc_value }
  end

  # GET /patients/:patient_id/packagesjson
  def packagesjson
    render :json => {patient: @patient}
    # render :json => {patient: @patient, imc_values: imc_values, days: days, max_imc_value: max_imc_value }
  end

  private
		# Use callbacks to share common setup or constraints between actions.
		def set_patient
		  @patient = Patient.find_by_slug(params[:patient_id])
		end

		def set_patient_package
      @patient_package = @patient.patient_packages.find(params[:id])
    end

    def get_patient_json
      @patient = Patient.find_by_id(params[:patient_id])
    end

    def get_patient_packages_json
      @patient_packages = @patient.patient_packages.find(params[:id])
    end

    def patient_package_params
      params.require(:patient_package).permit(:date,:package_id)
    end
end
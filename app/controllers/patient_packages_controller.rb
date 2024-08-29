class PatientPackagesController < ApplicationController
  before_action :set_patient
  before_action :set_patient_package, only: [:show]

  # GET /patients/:patient_id/patient_packages/:id
  def show
    @show_button_new = @patient_package.package.weeks <= 0 ||
                       @patient_package.sessions.count < (@patient_package.package.weeks * @patient_package.package.session_quantity ).to_i
  end

  # GET /patients/:patient_id/patient_packages/new
  def new
    # this commented code is for allow manual pacakge a session of empty package
    # active = @patient.patient_packages.active.nozeros.first
    # if active && active.sessions.not_initials.count < active.package.weeks
    #   redirect_to @patient, alert: 'Current Patient package is not completed.'
    # end
    active = @patient.patient_packages.active.first

    if active && active.package.weeks.zero?
      redirect_to patient_path(@patient), alert: 'El actual paquete no editable.'
      return
    end

    if active && active.sessions.count < (active.package.weeks * active.package.session_quantity.to_i)
      redirect_to patient_path(@patient), alert: 'El actual paquete no esta completado.'
      return
    end

    @patien_package = @patient.patient_packages.build
    @packages = Package.all
  end

  # POST /patients/:patient_id/patient_packages/create
  def create
    active_packages = @patient.patient_packages.active.first

    if active_packages && active_packages.sessions.not_initials.count < ( active_packages.package.weeks * active_packages.package.session_quantity.to_i)
      redirect_to patient_path(@patient), alert: 'El actual paquete no esta completado.'
      return
    end

    patient_package_params[:date] = patient_package_params[:date].to_date
    @patien_package = @patient.patient_packages.build(patient_package_params)
    @patien_package.dietitian = current_user
    @patien_package.status = :active

    respond_to do |format|
      if @patien_package.save
        format.html { redirect_to patient_package_show_path(@patient,@patien_package), success: 'El paquete ha sido creado.' }
        format.json { render :new, status: :created, location: @package }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patien_package.errors.full_messages.join(". ") << "." }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = User.find_by_id(params[:patient_id])
    # @patient = User.find_by_slug(params[:patient_id])
  end

  def set_patient_package
    @patient_package = @patient.patient_packages.find(params[:id])
  end

  def patient_package_params
    params.require(:patient_package).permit(:date, :package_id)
  end
end

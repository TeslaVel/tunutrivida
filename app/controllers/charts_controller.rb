class ChartsController < ApplicationController
  before_action :set_patient, only: %i[sessionsjson]


  # GET /patients/:patient_id/packages/:id/sessions/sessionsjson
  def sessionsjson
    sessions = patient_packages_data
    days = sessions.map { |sess| sess.date.to_date.strftime('%d-%m-%Y') }

    render json: {
      patient: @patient,
      days:,
      imc: {
        values: sessions.map(&:imc).compact
      },
      weight: {
        values: sessions.map(&:weight).compact
        # max_value: sessions.map(&:weight).max
      },
      body_grease: {
        values: sessions.map(&:body_grease).compact
        # max_value: sessions.map(&:body_grease).compact.max
      },
      muscle_mass: {
        values: sessions.map(&:muscle_mass).compact
        # max_value: sessions.map(&:muscle_mass).compact.max
      }
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = User.find_by_id(chart_params[:patient_id])
    # @patient = User.find_by_slug(params[:patient_id])
  end

  def patient_package
    @patient.patient_packages.find(chart_params[:patient_package_id])
  end

  def patient_packages_data
    all = chart_params[:all] == 'true'

    if all
      Session.where(patient_package_id: @patient.patient_packages.select(:id)).date_asc
    else
      [@patient.sessions.first] | patient_package.sessions.date_asc
    end
  end

  def chart_params
    params.permit(:patient_id, :patient_package_id, :all)
  end
end
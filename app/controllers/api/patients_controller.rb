class Api::PatientsController < Api::ApiController
  before_action :search_params, only: %i[search]

  def search
    srch = search_params[:text].downcase

    plist = current_user.patients.includes(:dietitian).select(:first_name, :last_name, :dietitian_id, :gender_id, :slug, :age)
    patients = (if srch.present?
                  plist.search_patients(srch)
                else
                  plist
                end).page(params[:page] || 1)

    render json: patients.as_json(
      except: [:gender_id, :dietitian_id],
      methods: [:sex],
      # include: {
      #   dietitian: { only: [:id, :email, :first_name] },
      # }
    )
  end

  def index
    patients = Patient.all
    render json: patients
  end

  def new
    patient = Patient.new
  end

  private
  def search_params
    params.permit(:text, :sort)
  end
end

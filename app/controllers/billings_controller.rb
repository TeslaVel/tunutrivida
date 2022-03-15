class BillingsController < ApplicationController
  before_action :set_billing, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    @billings = Billing.all
  end

  # GET /patients/1 or /patients/1.json
  def show
    # @sessions = @patient.sessions.id_desc
  end

  # GET /patients/new
  def new
    @billing = Billing.new
    @packages = Package.all
    @patients = Patient.all
    @billing_types = Billing::BillingTypes
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @billing = Billing.new(billing_params.merge(dietitian_id: current_user.id))

    if @billing.save
      redirect_to @billing, notice: "Billing was successfully created."
    else

      redirect_to new_billing_path(@billing), notice: @billing.errors.full_messages.join(". ") << "."
    end

  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to @billing, notice: "Billing was successfully updated." }
        format.json { render :show, status: :ok, location: @billing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @billing.destroy
    respond_to do |format|
      format.html { redirect_to billings_url, notice: "Billing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def billing_params
     params.require(:billing).permit(:total, :sub_total, :patient_package_id)
    end
end

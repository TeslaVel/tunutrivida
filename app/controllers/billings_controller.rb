# frozen_string_literal: true

# BillingsController
class BillingsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_billing, only: %i[ show edit items update destroy]
  before_action :set_patients, only: %i[ new edit ]
  # before_action :set_billing_for_item, only: %i[ create_billing_items create_paid_items]

  # GET /billings or /billings.json
  def index
    @billings = Billing.includes(:patient)
  end

  # GET /billings/1 or /billings/1.json
  def show
    # @sessions = @patient.sessions.id_desc
    @patient = @billing.patient

    used_package_ids = @billing.billing_items.where(itemable_type: 'Package').select(:itemable_id)
    used_product_ids = @billing.billing_items.where(itemable_type: 'Product').select(:itemable_id)
    used_discount_ids = @billing.billing_items.where(itemable_type: 'Discount').select(:itemable_id)

    @patient_packages = @patient.packages.where.not(id: used_package_ids) # .active
    @products = Product.where.not(id: used_product_ids) # .active
    @discounts = Discount.where.not(id: used_discount_ids) # .active

    # raise @patient.firs.to_yaml
  end

  # GET /billings/new
  def new
    @billing = Billing.new
    # @packages = Package.all
    # @patients = User.joins(:roles).where(roles: { name: 'patient' })
  end

  # POST /billings or /billings.json
  def create
    billingData = {
      dietitian_id: current_user.id,
      status: :unpaid,
      created_by_id: current_user.id
    }
    @billing = Billing.new(billing_params.merge(billingData))

    if @billing.save
      redirect_to billing_path(@billing), notice: "Billing was successfully created."
    else
      redirect_to new_billing_path(@billing), notice: @billing.errors.full_messages.join(". ") << "."
    end
  end

  # GET /billing/1
  def edit
  end

  # PATCH/PUT /billings/1 or /billings/1.json
  def update
    respond_to do |format|
      if @billing.update(update_billing_params)
        format.html { redirect_to @billing, notice: "Billing was successfully updated." }
        format.json { render :show, status: :ok, location: @billing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billings/1 or /billings/1.json
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

    def set_patients
      @patients = User.where.not(dietitian_id: nil)
    end

    # Only allow a list of trusted parameters through.
    def billing_params
     params.require(:billing).permit(:patient_id, :description, :patient_package_id)
    end

    def update_billing_params
      billing_params.permit(:description)
    end
end

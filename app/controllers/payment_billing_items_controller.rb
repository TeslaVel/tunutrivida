class PaymentBillingItemsController < ApplicationController
  before_action :set_billing, only: %i[ create destroy]
  before_action :set_payment_billing_item, only: %i[destroy]

  skip_before_action :verify_authenticity_token, only: [:create]


  # DELETE /billings/1.json
  def destroy
    @payment_item.destroy

    respond_to do |format|
      format.html { redirect_to billing_path(@billing), notice: 'Paid Item was successfully destroyed.' }
      format.js { render 'billings/show', :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find_by_id(params[:billing_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payment_billing_item
      @payment_item = PaymentBillingItem.find_by_id(params[:id])
    end
end

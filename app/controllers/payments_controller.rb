# frozen_string_literal: true

# PaymentsController
class PaymentsController < ApplicationController
  before_action :set_billing, only: %i[ create ]

  skip_before_action :verify_authenticity_token, only: [:create]

   # POST /billings or /billings.json
  def create
    pmt_params = {
      dietitian_id: payment_params[:current_user_id],
      created_by_id: payment_params[:current_user_id],
      billing_id: @billing.id
    }.with_indifferent_access

    # if payment_params[:item_ids].present?
    #   pmt_params[:payment_billing_items_attributes] = payment_params[:item_ids].map(&:to_h)
    # end

    @payment = Payment.build(pmt_params)

    respond_to do |format|
      if @payment.save
        # format.html { redirect_to billing_path(@billing), notice: 'Payment was successfully created.' }
        format.js { render 'billings/show', layout: false }
      else
        format.html { redirect_to billing_path(@billing), notice: @payment.errors.full_messages.join(". ") << "."}
        format.json { render json: @payment.errors.full_messages.join(". ") << ".", status: :unprocessable_entity }
      end
    end
  end

  # # POST /billings or /billings.json
  # def create
  #   pmt_params = {
  #     dietitian_id: payment_params[:current_user_id],
  #     created_by_id: payment_params[:current_user_id]
  #   }

  #   if payment_params[:item_ids].present?
  #     pmt_params[:payment_billing_items_attributes] = payment_params[:item_ids].map(&:to_h)
  #   end

  #   @payment = @billing.payments.build(pmt_params)

  #   respond_to do |format|
  #     if @payment.save
  #       format.html { redirect_to billing_path(@billing), notice: 'Paid items was successfully created.' }
  #       format.js { render 'billings/show', :layout => false }
  #     else
  #       format.html { redirect_to billing_path(@billing), notice: @payment.errors.full_messages.join(". ") << "."}
  #       format.json { render json: @payment.errors.full_messages.join(". ") << ".", status: :unprocessable_entity }
  #     end
  #   end
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find_by_id(params[:billing_id])
    end

    def payment_params
      params.require(:payment).permit(:current_user_id)
    end
end

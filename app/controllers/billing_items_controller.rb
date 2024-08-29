# frozen_string_literal: true

# BillingItemsController
class BillingItemsController < ApplicationController
  before_action :check_auth_for_all_origin
  before_action :set_billing, only: %i[ create destroy]
  before_action :set_billing_item, only: %i[destroy]

  # skip_before_action :verify_authenticity_token, only: [:create]

  # POST /billings/:billing_id/create_billing_items
  def create
    # BillingItem::ItemTypes.keys.include?('package'.to_sym)
    @billing_item = @billing.billing_items.build(corrected_billing_item_params)

    @current_user_id = billing_items_params[:current_user_id]

    respond_to do |format|
      if @billing_item.save
        # format.html { redirect_to billing_path(@billing), notice: 'Billing was successfully created.' }
        format.js { render 'billings/show', layout: false }
      else
        format.html { redirect_to billing_path(@billing), notice: @billing_item.errors.full_messages.join(". ") << "."}
        format.json { render json: @billing_item.errors.full_messages.join(". ") << ".", status: :unprocessable_entity }
      end
    end
  end


  # DELETE /billings/1 or /billings/1.json
  def destroy
    @billing_item.destroy

    respond_to do |format|
      format.html { redirect_to billing_path(@billing), notice: 'Billing item was successfully destroyed.' }
      # format.json { head :no_content }
      # format.js { render '/billings/destroy_item', :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find_by_id(params[:billing_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_billing_item
      @billing_item = BillingItem.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def billing_items_params
     params.require(:billing_item)
           .permit(
            :item_type,
            :product_id,
            :discount_id,
            :patient_package_id,
            :description,
            :quantity,
            :current_user_id
           )
    end

    def corrected_billing_item_params
      new_params = {
        target_conversion: @gbl_configuration.target_conversion,
        item_type: billing_items_params[:item_type].to_sym,
        description: billing_items_params[:description].strip,
        quantity: billing_items_params[:quantity].present? ? billing_items_params[:quantity] : 1,
        itemable_type: billing_items_params[:item_type].to_s.humanize
      }

      new_params[:itemable_id] = case billing_items_params[:item_type].to_sym
                                 when :product
                                    billing_items_params[:product_id]
                                 when :discount
                                    billing_items_params[:discount_id]
                                 when :package
                                    billing_items_params[:patient_package_id]
                                 end
      new_params
    end
end

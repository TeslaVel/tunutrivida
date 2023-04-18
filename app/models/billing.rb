class Billing < ApplicationRecord
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  belongs_to :patient

  has_many :billing_items
  has_many :payments
  has_many :payment_billing_items, through: :payments

  BillingTypes = %i[
    ballot
    invoice
  ].freeze
  

  enum billing_type: BillingTypes

  before_create :set_code_and_currency
  before_save :check_and_set_description

  private


  def set_code_and_currency
    gbl_config = GlobalConfiguration.first

    if gbl_config
      self.target_currency = gbl_config.target_currency
      self.target_conversion = gbl_config.target_conversion
      self.target_currency_code = gbl_config.target_currency_code
    end

    self.code = "B-#{"10000000".to_i + (Billing.maximum(:id)&.next || 1)}"
  end

  def check_and_set_description

    unless description.present?
      self.description = "Payment of"
    end
  end
end

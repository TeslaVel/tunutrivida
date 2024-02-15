# frozen_string_literal: true

# Billing model
class Billing < ApplicationRecord
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  has_many :billing_items
  has_one :payment
  has_many :payment_billing_items, through: :payment

  BILLING_ITEMS = %i[
    ballot
    invoice
  ].freeze

  BILLING_STATUS = %i[
    unpaid
    paid
  ].freeze

  enum billing_type: BILLING_ITEMS
  enum status: BILLING_STATUS

  before_create :set_code_and_currency
  before_save :check_and_set_description

  def obtain_pending_total_value
    total = billing_items.sum(:total).to_f
    discount_percentage = billing_items.inprocess&.discount_percentage_items&.first&.amount.to_f || 0
    total = (total - (total * (discount_percentage / 100))).round(2)
    total_conversion = (total * target_conversion.to_f).round(2)

    {total: total, total_conversion: total_conversion}
  end

  def obtain_total_value
    # total = billing_items.processed.sum(:total).to_f
    # discount_percentage = billing_items.processed&.discount_percentage_items&.first&.amount.to_f || 0
    # total = (total - (total * (discount_percentage / 100))).round(2)
    # total_conversion = (total * target_conversion.to_f).round(2)

    # {total: total, total_conversion: total_conversion}
    0
  end

  private

  def set_code_and_currency
    gbl_config = GlobalConfiguration.first

    if gbl_config
      self.target_currency = gbl_config.target_currency
      self.target_conversion = gbl_config.target_conversion
      self.target_currency_code = gbl_config.target_currency_code
    end

    self.code = "B-#{'10000000'.to_i + (Billing.maximum(:id)&.next || 1)}"
  end

  def check_and_set_description
    unless description.present?
      self.description = "Payment of"
    end
  end
end

# frozen_string_literal: true

# Payment
class Payment < ApplicationRecord
  belongs_to :billing
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  # has_many :payment_billing_items

  before_create :set_code
  after_create :set_billing_paid

  PAYMENT_STATUS = %i[
    unpaid
    paid
  ].freeze

  enum status: PAYMENT_STATUS

  # accepts_nested_attributes_for :payment_billing_items

  def set_code
    self.code = "P-#{'10000000'.to_i + (Payment.count&.next || 1)}"
  end

  def check_and_recalculate
    self.destroy if self.payment_billing_items.empty?
  end

  def set_billing_paid
    self.update(status: Payment::PAYMENT_STATUS.index(:paid))
    self.billing.update(status: Payment::PAYMENT_STATUS.index(status.to_sym))
  end
end

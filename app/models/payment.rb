class Payment < ApplicationRecord
  belongs_to :billing
  has_many :payment_billing_items

  before_create :set_code

  PaymentStatus = %i[
    paid
    unpaid
  ].freeze

  enum status: PaymentStatus

  accepts_nested_attributes_for :payment_billing_items

  def set_code
    self.code = "P-#{"10000000".to_i + (Payment.count&.next || 1)}"
  end

  def check_and_recalculate
    self.destroy if self.payment_billing_items.empty?
  end
end

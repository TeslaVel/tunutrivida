class PaymentBillingItem < ApplicationRecord
  belongs_to :payment
  belongs_to :billing_item


  after_create :set_processed
  after_destroy :set_inprocess

  private

  def set_processed
    self.billing_item.processed!
  end

  def set_inprocess
    billing_item.inprocess!
    payment.check_and_recalculate
  end
end

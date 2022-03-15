class Billing < ApplicationRecord
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  belongs_to :patient_package
  has_many :payments

  enum billing_type: [:ballot, :invoice], _prefix: :type

  after_create :set_code

  BillingTypes = [{value: :ballot},{value: :invoice}]

  def set_code
    self.code = "10000000".to_i + (Billing.maximum(:id)&.next || 1)
  end

end

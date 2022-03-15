class Payment < ApplicationRecord
  belongs_to :billing

  after_create :set_code

  def set_code
    self.code = "P-#{"10000000".to_i + (Payment.maximum(:id)&.next || 1)}"
  end
end

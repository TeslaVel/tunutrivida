class Discount < ApplicationRecord
	# has_many :billing_items, as: :itemable
	DiscountTypes = %i[
    value
    percentage
  ].freeze

  enum discount_type: DiscountTypes


  DiscountStatus = %i[
    enable
    disabled
  ].freeze

  enum status: DiscountStatus


   alias_attribute :price, :amount
end

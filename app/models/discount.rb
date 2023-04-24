class Discount < ApplicationRecord
	# has_many :billing_items, as: :itemable
	DiscountTypes = %i[
    value
    percentage
  ].freeze

  DiscountStatus = %i[
    enable
    disabled
  ].freeze

  enum discount_type: DiscountTypes
  enum status: DiscountStatus

  alias_attribute :price, :amount

  paginates_per 10
end

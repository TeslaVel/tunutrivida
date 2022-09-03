class Product < ApplicationRecord
	ProductStatus = %i[
    enable
    disabled
  ].freeze

  enum status: ProductStatus
end

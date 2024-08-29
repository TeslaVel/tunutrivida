class Product < ApplicationRecord
	ProductStatus = %i[
    enable
    disabled
  ].freeze

  enum status: ProductStatus

  paginates_per 10
end

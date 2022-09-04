class Indicator < ApplicationRecord
  belongs_to :gender
  belongs_to :indicator_type

  scope :order_by_id, -> { order(id: :asc) }

  paginates_per 8
end

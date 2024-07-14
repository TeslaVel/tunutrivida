class Indicator < ApplicationRecord
  belongs_to :gender
  belongs_to :indicator_type
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id', optional: true

  scope :order_by_id, -> { order(id: :asc) }
  scope :order_by_type, -> { order(:id ,:indicator_type_id) }

  scope :within_range, -> (value) { where('value_min <= ? AND value_max > ?', value, value) }

  scope :indicators_by_type, -> (type) {
    joins(:indicator_type).where(indicator_types: { name: type.upcase })
  }

  paginates_per 8
end

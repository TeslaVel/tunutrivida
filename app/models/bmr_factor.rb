# frozen_string_literal: true

# BmiFactor model
class BmrFactor < ApplicationRecord
  belongs_to :gender
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'

  paginates_per 8
end

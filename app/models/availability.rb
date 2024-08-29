# frozen_string_literal: true

# Availability
class Availability < ApplicationRecord
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"

  validates :dietitian_id, uniqueness: true
end

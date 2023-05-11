# frozen_string_literal: true

class AppointmentSetting < ApplicationRecord
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
end

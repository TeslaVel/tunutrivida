# frozen_string_literal: true

# Conversation model
class Conversation < ApplicationRecord
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  has_many :notes
end

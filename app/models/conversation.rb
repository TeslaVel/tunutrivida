# frozen_string_literal: true

# Conversation model
class Conversation < ApplicationRecord
  belongs_to :dietitian, class_name: 'User', foreign_key: 'user_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'user_id'

  has_many :notes
  # validates :message, presence: true
end

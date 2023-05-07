class Task < ApplicationRecord
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  # belongs_to :patient
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'

  TASK_STATUS_TYPES = %i[
    pending
    finished
  ].freeze

  enum status: TASK_STATUS_TYPES
end

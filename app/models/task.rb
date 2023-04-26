class Task < ApplicationRecord
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  belongs_to :patient

  TASK_STATUS_TYPES = %i[
    pending
    finished
  ].freeze

  enum status: TASK_STATUS_TYPES
end

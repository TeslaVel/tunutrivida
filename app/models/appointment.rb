class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'

  Appointment_Types = %i[
    phone_call
    video_call
  ].freeze

  enum appointment_type: Appointment_Types

  Status_Types = %i[
    pending
    ocurred
    happening
    cancelld
  ].freeze

  enum status: Status_Types

  before_save :set_title

  private

  def set_title
    self.title = "(#{patient.first_name} #{patient.last_name[0]})"
  end
end

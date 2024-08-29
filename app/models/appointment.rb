# frozen_string_literal: true

# Appointment
class Appointment < ApplicationRecord
  # belongs_to :patient
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'

  APPOINTMENT_TYPES = %i[
    in_person
    phone_call
    video_call
  ].freeze

  enum appointment_type: APPOINTMENT_TYPES

  STATUS_TYPES = %i[
    pending
    ocurred
    happening
    cancelled
  ].freeze

  enum status: STATUS_TYPES

  before_save :set_title

  scope :current_and_future, -> {
    where(start_date: Time.zone.today..(Time.zone.today + 5.days), status: statuses.values_at(:pending, :happening))
  }

  validates :appointment_type, presence: true
  validates :status, presence: true

  private

  def set_title
    self.title = "(#{patient.first_name} #{patient.last_name[0]})"
  end
end

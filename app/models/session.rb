class Session < ApplicationRecord
  belongs_to :patient
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  belongs_to :patient_package
  has_one :package, through: :patient_package
  belongs_to :activity_factor

  before_create :check_and_set_initial

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :id_asc, -> { order(id: :asc) }
  scope :not_initials, -> { where(initial: :false) }

  private

  def check_and_set_initial
    unless patient.sessions.present?
      self.initial = true
    end
  end
end

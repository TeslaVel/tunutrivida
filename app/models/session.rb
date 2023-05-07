class Session < ApplicationRecord
  # belongs_to :patient
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  belongs_to :patient_package
  has_one :package, through: :patient_package
  belongs_to :activity_factor

  before_create :check_and_set_initial
  before_save :set_imc, if: -> {height_changed? || weight_changed?}

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :id_asc, -> { order(id: :asc) }
  scope :not_initials, -> { where(initial: :false) }


  validates :date, presence: true

  private

  def check_and_set_initial
    unless patient.sessions.present?
      self.initial = true
    end
  end

   def set_imc

    return unless height.present? && weight.present?

    h2 = (height*height).round(2)
    self.imc = (weight / h2 ).round(2)
  end
end

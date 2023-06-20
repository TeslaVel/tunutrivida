class Session < ApplicationRecord
  # belongs_to :patient
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  belongs_to :patient_package
  has_one :package, through: :patient_package
  belongs_to :activity_factor

  before_create :check_and_set_initial
  after_create :check_and_finish_package
  before_save :set_imc, if: -> {weight_changed?}

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :id_asc, -> { order(id: :asc) }
  scope :not_initials, -> { where(initial: false) }


  validates :date, presence: true

  private

  def check_and_set_initial
    unless patient.sessions.present?
      self.initial = true
    end
  end

 def check_and_finish_package
    if patient_package.package.session_quantity.to_i == patient_package.sessions.count
      patient_package.update(status: :finished)
    end
  end

   def set_imc
    return unless height.present? && weight.present?

    h2 = (height.to_f * height.to_f).round(2)
    self.imc = (weight.to_f / h2).round(2)

    bmr_factor = BmrFactor.where('gender_id = ? AND source = ?', patient.gender_id, 1).first

    if bmr_factor
      self.bmr = (bmr_factor.base_value.to_f +
                    (bmr_factor.base_weight.to_f * weight) +
                    (bmr_factor.base_height.to_f * height) -
                    (bmr_factor.base_age.to_f * patient.age))
    end

    # Mifflin Para hombres:
    # BMR = (10 × peso en kg) + (6.25 × altura en cm) - (5 × edad en años) + 5
    # Mifflin Para mujeres:
    # BMR = (10 × peso en kg) + (6.25 × altura en cm) - (5 × edad en años) - 161
  end
end

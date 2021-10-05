class Session < ApplicationRecord
  belongs_to :patient
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  # belongs_to :dietitian
  belongs_to :patient_package
  has_one :package, through: :patient_package
  belongs_to :activity_factor

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :id_asc, -> { order(id: :asc) }

end

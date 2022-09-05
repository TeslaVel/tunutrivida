class PatientPackage < ApplicationRecord
  belongs_to :package
  belongs_to :patient
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"

  has_many :sessions
  has_one :billing
  has_many :billing_items, as: :itemable # relacion polimorfica

  before_create :finished_all_package
  after_create :check_and_set_status

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :active, -> { where(status: :active) }


  PackageStatus = %i[
    active
    finished
    closed
  ].freeze

  enum status: PackageStatus

  private
  	def finished_all_package
  		self.patient.patient_packages.update_all(status: :finished)
  	end

    def check_and_set_status
    if package.weeks <= 0
      self.status = :finished
    end
  end
end

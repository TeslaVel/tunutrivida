class PatientPackage < ApplicationRecord
  belongs_to :package
  belongs_to :patient
  belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
  
  has_many :sessions

  before_save :finished_all_package


  # scope :date_desc, -> { order(date: :desc) }
  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :id_asc, -> { order(id: :asc) }

  

  private
  	def finished_all_package
  		self.patient.patient_packages.update_all(status: false)
  	end
end

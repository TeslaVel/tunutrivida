class Package < ApplicationRecord
	has_many :patient_packages
	has_many :sessions, through: :patient_packages
end

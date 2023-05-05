class Package < ApplicationRecord
	has_many :patient_packages
	has_many :sessions, through: :patient_packages

	PackageStatus = %i[
    enable
    disabled
  ].freeze

  enum status: PackageStatus

	scope :active, ->{ where(status: :enable) }

	paginates_per 10
end

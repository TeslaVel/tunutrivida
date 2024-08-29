class Patient < ApplicationRecord
	# self.table_name = "users"

	# include PgSearch::Model

	# # has_one :user
	# # has_one :role
	# belongs_to :dietitian, class_name: 'User', optional: true
  # belongs_to :gender
	# has_many :user_roles
	# has_many :roles, through: :user_roles
  # has_many :patients, class_name: 'User', foreign_key: 'dietitian_id'
	# has_many :patient_packages, class_name: 'PatientPackage', foreign_key: 'patient_id'
  # has_many :sessions, through: :patient_packages
  # has_many :packages, through: :patient_packages
	# has_many :billings
  # has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'
  # has_many :dietitian_appointments, class_name: 'Appointment', foreign_key: 'dietitian_id'
	# has_many :tasks

	# before_create :set_date_of_birth
	# after_validation :set_slug, only: [:create, :update]
	# after_create :create_user_for_patient

	# scope :last_sessions, -> { self.sessions.order(date: :asc) }
	# scope :active_patients, ->{ where(status: :active) }

	# validates :first_name, presence: true
	# validates :last_name, presence: true

	# PatientStatus = %i[
  #   active
  #   inactive
  # ].freeze

  # enum status: PatientStatus

	# paginates_per 6

	# pg_search_scope :search_patients,
  #                 against: { first_name: 'A', last_name: 'B' },
  #                 using: {
  #                   tsearch: {
  #                     dictionary: 'english', tsvector_column: 'searchable'
  #                   }
  #                 }
  #                 # using: { tsearch: { dictionary: 'english' } }

	# def set_slug
	# 	self.slug = "#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
	# end

	# def full_name
	# 	"#{first_name} #{last_name}"
	# end

	# def to_param
	# 	"#{slug}"
	# end

	# def sex
	# 	gender&.name
	# end

	# private

	# def create_user_for_patient
	# 	username = nil
	# 	loop do
	# 		username = "#{first_name.parameterize}#{slug}"
	# 		break unless User.exists?(username: username)
  #   end

	# 	org = dietitian.organization

	# 	return unless org
	# 	return unless username.present?

	# 	user = User.new(
	# 		username: username,
	# 		email: "#{username}@example.com",
	# 		password: 'tunutrivida',
	# 		password_confirmation: 'tunutrivida',
	# 		first_name: first_name,
	# 		last_name: last_name,
	# 		organization_id: org.id,
	# 		patient_id: id
	# 	)
	# 	user.add_role(:patient, dietitian)
	# end

	# def set_date_of_birth
	# 	now = Time.now.utc.to_date
	# 	dob = date_of_birth
  # 	self.age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	# end
end

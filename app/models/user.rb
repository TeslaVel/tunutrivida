class User < ApplicationRecord
  include PgSearch::Model
  has_secure_password

  before_create :set_slug
  before_create :set_date_of_birth
  before_update :set_date_of_birth if [:date_of_birth]
  after_create :set_temporal_email_and_username

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
	validates :last_name, presence: true

  belongs_to :organization
 

  # user onwer general
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :entries
  has_many :notifications, class_name: 'Notification', foreign_key: 'recipient'


  # patient owner
  belongs_to :dietitian, class_name: 'User', optional: true
  belongs_to :gender
  has_one :patient_conversation, class_name: 'Conversation', foreign_key: 'patient_id'
	has_many :patient_packages, class_name: 'PatientPackage', foreign_key: 'patient_id'
  has_many :sessions, through: :patient_packages
  has_many :packages, through: :patient_packages
	has_many :billings
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'
	has_many :tasks

  scope :last_sessions, -> { self.sessions.order(date: :asc) }


  # dieitian owner
  has_one :availability, foreign_key: "dietitian_id"
  has_one :appointment_setting, foreign_key: "dietitian_id"
  has_many :dietitian_conversations, class_name: 'Conversation', foreign_key: 'dietitian_id'
  has_many :dietitian_appointments, class_name: 'Appointment', foreign_key: 'dietitian_id'
  has_many :patients, class_name: 'User', foreign_key: 'dietitian_id'


  scope :only_dieitians, ->(organization_id = 1) { joins(user_roles: :role).where(role: {name: 'dietitian'}, organization_id: organization_id) }
  scope :active_patients, ->(organization_id = 1) { where(status: :active).joins(user_roles: :role).where(role: {name: 'patient'}, organization_id: organization_id) }


  # new
  PatientStatus = %i[
    active
    inactive
  ].freeze

  enum status: PatientStatus

  paginates_per 6

  pg_search_scope :search_patients,
                  against: { first_name: 'A', last_name: 'B' },
                  using: {
                    tsearch: {
                      prefix: true,
                      dictionary: 'english',
                      tsvector_column: 'searchable'
                    }
                  }


  def is_patient?
    return true if has_role? :patient

    false
  end

  def is_dietitian?
    return true if has_role? :dietitian

    false
  end

  def full_name
		"#{first_name} #{last_name}"
	end

  def get_initials
    stripped_first_name = first_name.strip
    stripped_last_name = last_name.strip

    "#{stripped_first_name[0].capitalize}.#{stripped_last_name[0].capitalize}"
  end

  def first_name_initial
    stripped_first_name = first_name.strip
    stripped_last_name = last_name.strip

    "#{stripped_first_name[0].capitalize}. #{stripped_last_name}"
  end

  include RolesConcern

  def add_role(role, created_by = nil)
  	# permited = Role::ROLES_TYPES.include?(role)
  	# return false unless permited
  	# newrole = Role::ROLES_TYPES[role].to_s
  	return false unless !self.has_role? role
  	exists_role = Role.find_by_name(role.to_s) || false
  	return false unless exists_role

    if created_by
  	 UserRole.create(user: self ,role: exists_role, created_by_id: created_by.id)
    else
     UserRole.create(user: self ,role: exists_role)
    end
  end

  private

  def set_slug
		self.slug = "#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
	end

  # def to_param
	# 	"#{slug}"
	# end

  def sex
		gender&.name
	end

  def set_temporal_email_and_username
    skiped = ['tunutrividalb@gmail.com', 'francisberrios@example.com']
    return if skiped.include?(email)

    uname = "#{first_name.parameterize}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
    mail = "#{uname}@example.com"

    # if email.present? && 
    #   uname = 'tunutrividalb'
    #   mail = email
    # end

    self.username = uname
    self.email = mail
    self.save!
  end

  def set_date_of_birth
    return unless date_of_birth

		now = Time.now.utc.to_date
		dob = date_of_birth
  	self.age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end
end

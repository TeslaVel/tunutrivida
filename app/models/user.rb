class User < ApplicationRecord
  include PgSearch::Model
  has_secure_password

  before_create :set_slug
  before_create :calculate_age
  before_update :calculate_age if [:date_of_birth]
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
  has_many :patient_packages, class_name: 'PatientPackage', foreign_key: 'patient_id', dependent: :destroy
  has_many :sessions, through: :patient_packages
  has_many :packages, through: :patient_packages, dependent: :delete_all
  has_many :patient_billings, foreign_key: 'patient_id'
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'
  has_many :tasks
  has_many :patient_conditions, foreign_key: 'patient_id'
  has_many :conditions, through: :patient_conditions
  has_many :restricted_ingredient_conditions, through: :conditions
  scope :last_sessions, -> { sessions.order(date: :asc) }

  # dieitian owner
  has_many :dietitian_billings, foreign_key: 'dietitian_id'
  has_one :availability, foreign_key: 'dietitian_id'
  has_one :appointment_setting, foreign_key: 'dietitian_id'
  has_many :dietitian_conversations, class_name: 'Conversation', foreign_key: 'dietitian_id'
  has_many :dietitian_appointments, class_name: 'Appointment', foreign_key: 'dietitian_id'
  has_many :patients, class_name: 'User', foreign_key: 'dietitian_id'

  has_one_attached :image, dependent: :delete_all

  scope :only_dieitians, ->(organization_id = 1) { joins(user_roles: :role).where(role: {name: 'dietitian'}, organization_id: organization_id) }
  scope :active_patients, ->(organization_id = 1) { where(status: :active).joins(user_roles: :role).where(role: {name: 'patient'}, organization_id: organization_id) }

  # new
  PATIENT_STATUS = %i[
    active
    inactive
  ].freeze

  enum status: PATIENT_STATUS

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

  def bmr_factor
    BmrFactor.find_by(source: self.bmr_factor_source, gender_id: self.gender_id)
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
  	 UserRole.create(user: self, role: exists_role, created_by_id: created_by.id)
    else
     UserRole.create(user: self, role: exists_role)
    end
  end

  def image_url
    return unless image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(image).strip
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

    self.username = uname
    self.email = mail
    # self.save!
    save!
  end

  def calculate_age
    return unless date_of_birth

		now = Time.now.utc.to_date
		dob = date_of_birth
  	self.age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

  def self.create_patient_from_insant_session(current_user_id, patient_params, instant_session_id, package_id)
    self.transaction do
      current_user = User.find(current_user_id)
      instant = InstantSession.find(instant_session_id)

      patient = User.create(patient_params)
      patient_package_params = {
        date: instant.date,
        dietitian_id: current_user.id,
        status: :active,
        package_id: package_id
      }
      patient_package = patient.patient_packages.create(patient_package_params)

      session_params = {
        date: instant.date,
        weight: instant.weight,
        height: instant.height,
        waist: instant.waist,
        hip: instant.hip,
        high_abdomen: instant.high_abdomen,
        low_abdomen: instant.low_abdomen,
        ideal_weight: instant.ideal_weight,
        body_grease: instant.body_grease,
        visceral_grease: instant.visceral_grease,
        muscle_mass: instant.muscle_mass,
        bone_mass: instant.bone_mass,
        bmr: instant.bmr,
        metabolic_age: instant.metabolic_age,
        water_percentage: instant.water_percentage,
        physical_complexion: instant.physical_complexion,
        activity_factor_id: instant.activity_factor_id,
        created_by_id: current_user.id,
        patient_id: patient.id,
        dietitian_id: current_user.id
      }
      session = patient_package.sessions.create(session_params)

      raise StandardError.new "Error" unless patient.persisted? && patient_package.persisted? && session.persisted?

      patient
    rescue
      raise ActiveRecord::Rollback
    end
  end
end

class Patient < ApplicationRecord
	include PgSearch::Model
  
	after_validation :set_slug, only: [:create, :update]
	after_create :ctate_user_for_patient

	belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
	has_one :user
	has_one :role
	belongs_to :gender
	has_many :patient_packages
  has_many :sessions, through: :patient_packages
  has_many :packages, through: :patient_packages
	has_many :billings

	PatientStatus = %i[
    active
    inactive
  ].freeze

  enum status: PatientStatus

	paginates_per 5

	pg_search_scope :search_patients,
                  against: { first_name: 'A', last_name: 'B' },
                  using: {
                    tsearch: {
                      dictionary: 'english', tsvector_column: 'searchable'
                    }
                  }
                  # using: { tsearch: { dictionary: 'english' } }
  # este scope no funcina
  # scope :active_packages, ->{ patient_packages.where(status: :active).first }
  scope :active, ->{ where(status: :active) }

	def set_slug
		self.slug = "#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def to_param
		"#{slug}"
	end

	# def active_package
 #  	self.patient_packages.find_by_status(:active)
 #  end


	def ctate_user_for_patient
		username = "#{self.first_name.parameterize}@#{self.slug}"

		user = User.create(
			username: username,
			email: "#{username}@example.com",
			password: 'tunutrilau',
			password_confirmation: 'tunutrilau',
			first_name: self.first_name,
			last_name: self.last_name,
			patient_id: self.id
		)
		# user.save!
		user.add_role(:patient, self.dietitian)
	end


	# def self.search(search)
	# 	if search
	# 	    where("concat(first_name,' ',last_name) ILIKE ?", "%#{search}%")
	# 	else
	# 	    all
	# 	end
	# end 
end

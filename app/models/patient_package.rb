class PatientPackage < ApplicationRecord
  belongs_to :package
  # belongs_to :patient
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'

  has_many :sessions, dependent: :delete_all
  has_one :billing
  has_many :billing_items, as: :itemable # relacion polimorfica

  # after_create :finished_all_package
  after_create :create_appointments_for_packages
  after_create :check_and_set_status

  scope :date_desc, -> { order(date: :desc) }
  scope :date_asc, -> { order(date: :asc) }
  scope :id_desc, -> { order(id: :desc) }
  scope :order_status, -> { order(created_at: :desc, status: :asc) }
  scope :active, -> { where(status: :active) }

  validates :date, presence: true

  PackageStatus = %i[
    active
    finished
    closed
  ].freeze

  enum status: PackageStatus

  private

  	# def finished_all_package
    #   if package.session_quantity.to_i == sessions.count
  	# 	  self.patient.patient_packages.update_all(status: :finished)
    #   end
  	# end

    def check_and_set_status
      # if an empty packages created that will be finished
      if package.weeks <= 0
        self.status = :finished
      end
    end

    def create_appointments_for_packages
      # no deberia ser asi
      # weeks = package.weeks
      # return unless weeks > 1

      # availability = dietitian.availability
      # date_now = Time.zone.now

      # begin
      #   weeks.times do
      #     if [0, 6].include?(date_now.strftime('%w').to_i)
      #       date_now = date_now + 1.day
      #     else
      #       Appointment.create(
      #         start_date: date_now,
      #         time_start: availability.time_start.strftime('%H:%M %p'),
      #         time_end: (availability.time_end + 15.minutes).strftime('%H:%M %p'),
      #         dietitian_id: dietitian.id,
      #         patient_id: patient.id
      #       )

      #       date_now = date_now + 7.day
      #     end
      #   end
      # rescue => e
      #   puts "Se encontro un error en automated appointments. #{e.message}"
      # end
    end
end

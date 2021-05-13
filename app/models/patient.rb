class Patient < ApplicationRecord

	after_validation :set_slug, only: [:create, :update]

	has_one :role
	belongs_to :dietitian, :class_name => "User", :foreign_key => "dietitian_id"
	belongs_to :gender
	has_many :sessions


	def set_slug
		self.slug = "#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
	end

	def to_param
		"#{slug}"
	end
end

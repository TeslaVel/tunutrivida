class Gender < ApplicationRecord
	validates :name, :description, presence: true
end

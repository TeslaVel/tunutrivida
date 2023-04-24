class Organization < ApplicationRecord
  has_many :users
  has_many :patients, through: :users
  has_many :organiztion_memberships
end

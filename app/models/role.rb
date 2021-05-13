class Role < ApplicationRecord

	has_and_belongs_to_many :users, :join_table => :user_roles
	#has_many :roles, through: :user_roles

	
	belongs_to :resource,
             :polymorphic => true,
             :optional => true
end

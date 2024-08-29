class Role < ApplicationRecord
	has_and_belongs_to_many :users, :join_table => :user_roles

	ROLES_TYPES = {
    super_admin: 'super_admin',
    dietitian: 'dietitian',
    patient: 'patient',
  }

	belongs_to :resource,
             :polymorphic => true,
             :optional => true
end

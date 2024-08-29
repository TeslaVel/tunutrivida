module RolesConcern
	extend ActiveSupport::Concern

	def has_role? role
		return self.roles.find_by_name(role.to_s) || false
	end
end
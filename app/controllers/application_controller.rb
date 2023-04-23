class ApplicationController < ActionController::Base
	before_action :set_locale
	before_action :authenticate_user!
	before_action :get_global_configurations

	def set_locale
		I18n.locale = 'es'
	end

	def get_global_configurations
		@organization = current_user&.organization
		@gbl_configuration = GlobalConfiguration.first
	end

end

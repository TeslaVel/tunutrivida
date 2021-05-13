class ApplicationController < ActionController::Base
	before_action :set_locale

	before_action :authenticate_user!

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end
	
	def set_locale
		I18n.locale = 'es'
	end
end

# frozen_string_literal: true

# ClientsController
class ClientsController < ApplicationController
	before_action :set_locale

	rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

	def set_locale
		I18n.locale = 'es'
	end
end

class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_user
	before_action :set_locale

	before_action :get_global_configurations

	def set_locale
		I18n.locale = 'es'
	end

	def get_global_configurations
		@organization = current_user&.organization
		@gbl_configuration = GlobalConfiguration.first
	end

  def current_user
		@current_user ||=
			if graphql_or_api_request?
				auth_header = request.headers['Authorization']
				token = auth_header.split(' ').last if auth_header.present?
				return nil unless token.present?
				payload = JwtService.decode(token)
				User.find_by(id: payload['user_id'])
			else
				User.find_by(id: session[:user_id])
			end
  end

	def authenticate_all
    unless current_user
			if graphql_or_api_request?
				raise GraphQL::ExecutionError.new("You need to authenticate to perform this action")
			else
				flash[:error] = "You must be logged in to access this section"
				redirect_to login_path
			end
    end
  end

	private

  def graphql_or_api_request?
    request.headers['Content-Type'] == 'application/json'
  end
end

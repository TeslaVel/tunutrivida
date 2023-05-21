class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_user
	before_action :set_locale
	before_action :get_global_configurations

	GLOBAL_EMOJIS = ['👍', '👏', '☺️', '🎉', '🤔', '😎', '🙏']

	def set_locale
		I18n.locale = 'es'
	end

	def get_global_configurations
		@organization = current_user&.organization
		@gbl_configuration = GlobalConfiguration.first
		@notifications = Notification.where(recipient_id: current_user&.id, seen: false, notification_type: :comment)
		@emails = Notification.where(seen: false, notification_type: :contactus)
	end

  def current_user
		@current_user ||=
			if graphql_request?
				token = request.headers['Authorization']&.split&.last
				return nil unless token.present?
				JwtService.decode(token)
			else
				User.find_by(id: session[:user_id])
			end
  end

	def authenticate_all
    unless current_user
				# !params[:query].match('AuthMutation') &&
			if graphql_request? &&
				 params[:operationName] != 'AuthMutation' &&
				!params[:query].match('AuthMutation') &&
				!params[:query].match('CreateContactUs') &&
				 params[:operationName] != 'CreateContactUs'
				 return {
				 	error: "You need to authenticate to perform this action",
				 	status: :unauthorized
				 }
				# raise GraphQL::ExecutionError.new("You need to authenticate to perform this action")
			end

			if !graphql_request?
				flash[:error] = "You must be logged in to access this section"
				redirect_to login_path
			end
    end
  end

	private

  def graphql_request?
    request.headers['Content-Type'] == 'application/json'
  end
end

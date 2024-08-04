# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_locale
  before_action :get_global_configurations

	before_action :check_auth_for_all_origin, only: %i[ update_dolar_price ]

	GLOBAL_EMOJIS = ['👍', '👏', '☺️', '🎉', '🤔', '😎', '🙏']

	def set_locale
		I18n.locale = 'es'
	end

	def get_global_configurations
		@organization = current_user&.organization
		@gbl_configuration = GlobalConfiguration.first
		@notifications = Notification.where(recipient_id: current_user&.id, seen: false, notification_type: %i[comment note])
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

	def check_auth_for_all_origin
		return if params[:operationName].in?(%w[AuthMutation CreateContactUs])
		return if params[:query]&.match('AuthMutation') || params[:query]&.match('CreateContactUs')

    unless current_user.present?
			if graphql_request?
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

  def update_dolar_price
  	id = params[:id]
  	newPrice = params[:global_configuration][:target_conversion]

		@gbl_configuration.target_conversion = newPrice.to_f

		respond_to do |format|
      if @gbl_configuration.save
				@notifications = Notification.where(recipient_id: current_user&.id, seen: false, notification_type: :comment)
				@emails = Notification.where(seen: false, notification_type: :contactus)

        format.js { render 'layouts/shared/topbar', layout: false }
      else
        format.json { render json: @gbl_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

	private

  def graphql_request?
    request.headers['Content-Type'] == 'application/json'
  end
end

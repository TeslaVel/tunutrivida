require 'jwt'
require_relative '../../services/jwt_service'

class Api::ApiController < ActionController::API
  helper_method :current_user
  before_action :authenticate_request

  def current_user
		@current_user
  end

  private

  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header.present?
    @current_user ||= JwtService.decode(token)

    if @current_user.nil?
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end

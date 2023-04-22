require 'jwt'
require_relative '../../services/jwt_service'


class Api::ApiController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header.present?
    @current_user = JwtService.decode(token)
    if @current_user.nil?
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
    # begin
    #   @decoded = JwtService.decode(token)
    #   # @current_user = User.find(@decoded['user_id'])
    # rescue JWT::DecodeError
    #   render json: { error: 'Invalid token' }, status: :unauthorized
    # end
  end
end

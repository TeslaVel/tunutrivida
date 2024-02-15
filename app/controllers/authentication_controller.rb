# frozen_string_literal: true

# AuthenticationController
class AuthenticationController < ApplicationController
  layout 'auth'

  def login
  end

  def authenticate
    user = User.find_by(username: auth_params[:username])

    if user&.authenticate(auth_params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'Logged in successfully!'

      # ClientsChannel.broadcast_to('clients_channel', message: 'Hello, world!')
      # ActionCable.server.broadcast("clients_channel", {user_id: user.id, message: 'Hello, world!'})
    else
      flash.now[:alert] = 'Email or password is invalid'
      redirect_to login_path, alert: 'Logged error'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: 'logged out successfully!'
  end

  private

  def auth_params
    params.require(:auth)
          .permit(
            :password,
            :username)
  end
end
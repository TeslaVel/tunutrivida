class Api::SessionController < Api::ApiController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JwtService.encode({ user_id: user.id })
      render json: { token: token, user: user }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end

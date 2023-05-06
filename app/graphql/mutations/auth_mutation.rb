module Mutations
  class AuthMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :auth_type, Types::AuthType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user && user.valid_password?(password)
        {
          token: JwtService.encode({ user_id: user.id }),
          email: email,
          first_name: user.first_name,
          last_name: user.last_name,
        }
      else
        {error: 'Invalid email or password'}
      end
    end
  end
end


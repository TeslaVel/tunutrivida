module Mutations
  class AuthMutation < BaseMutation
    description 'AuthMutation'
    argument :email, String, required: true
    argument :password, String, required: true

    field :auth_type, Types::AuthType, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        {
          token: JwtService.encode({ user_id: user.id }),
          email: email,
          first_name: user.first_name,
          last_name: user.last_name,
          dietitian_id: user.dietitian_id
        }
      else
        {error: 'Invalid email or password'}
      end
    end
  end
end


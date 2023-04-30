module Mutations
  class AuthMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user && user.valid_password?(password)
        token = JwtService.encode({ user_id: user.id })
        {token: token}
      else
        {error: 'Invalid email or password'}
      end
    end
  end
end


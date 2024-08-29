module Mutations
  class AuthMutation < BaseMutation
    description 'AuthMutation'
    argument :email, String, required: true
    argument :password, String, required: true

    field :auth, Types::AuthType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        user
      else
        { error: 'Invalid email or password' }
      end
    end
  end
end


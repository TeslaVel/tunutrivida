module Mutations
  class AuthMutation < BaseMutation
    description 'AuthMutation'
    argument :email, String, required: true
    argument :password, String, required: true


    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        # current_user = user
        # context[:current_user] = user

        {
          id: user.id,
          token: JwtService.encode({ user_id: user.id }),
          email: email,
          first_name: user.first_name,
          last_name: user.last_name,
          dietitian_id: user.dietitian_id,
          height: user.sessions&.first&.height,
          weight: user.sessions&.first&.weight,
          imc: user.sessions&.first&.imc,
          age: user.age,
          gender: user&.gender.name.downcase
        }
      else
        { error: 'Invalid email or password' }
      end
    end
  end
end


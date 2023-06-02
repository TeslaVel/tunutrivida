module Types
  class AuthType < BaseObject
    field :id, String
    field :email, String
    field :token, String
    field :password, String
    field :first_name, String
    field :last_name, String
    field :dietitian_id, String
    field :height, String
    field :weight, String
    field :imc, String
    field :age, String
    field :gender, String

    # def height
    #   binding.pry
    #   if object.is_a?(Hash)
    #     object[:sessions]&.first&.height
    #   else
    #     object.sessions&.first&.height
    #   end
    # end

    # def weight
    #   binding.pry
    #   object.sessions&.first&.weight
    # end

    # def age
    #   object.age
    # end

    # def imc
    #   object.sessions&.first&.imc
    # end
  end
end

module Types
  class AuthType < BaseObject
    field :email, String
    field :password, String
    field :token, String
  end
end

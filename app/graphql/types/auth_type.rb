module Types
  class AuthType < BaseObject
    field :email, String
    field :token, String
    field :password, String
    field :first_name, String
    field :last_name, String
    field :dietitian_id, String
  end
end

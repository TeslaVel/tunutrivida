module Types
  class ContactUsType < BaseObject
    field :id, ID, null: false
    field :first_name, String
    field :last_name, String
    field :email, String, null: false
    field :message, String, null: false
  end
end

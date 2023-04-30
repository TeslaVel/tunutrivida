module Types
  module InputTypes
    class ContactUsInputType < Types::BaseInputObject
      argument :first_name, String, required: true
      argument :last_name, String
      argument :email, String
      argument :message, String, required: true
    end
  end
end

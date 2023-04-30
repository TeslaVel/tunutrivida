module Mutations
  class CreateContactUs < BaseMutation
    argument :email, String, required: true
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :message, String, required: true

    field :contact, Types::ContactUsType, null: true

    def resolve(email:, first_name:, last_name:, message:)
      contact = ContactUs.create(
        first_name: first_name,
        last_name: last_name,
        email: email,
        message: message
      )

      if contact.persisted?
        { contact: contact }
      else
        { errors: 'hubo error' }
      end
    end
  end
end


# module Mutations
#   class CreateContactUs < BaseMutation
#     argument :email, String, required: true
#     argument :first_name, String, required: false
#     argument :last_name, String, required: false
#     argument :message, String, required: true

#     field :contactus, Types::ContactUsType
#     field :errors, [String], null: false

#     def resolve(email:, first_name:, last_name:, message:)
#       contact = ContactUs.create(
#         first_name: first_name,
#         last_name: last_name,
#         email: email,
#         message: message
#       )

#       # if contact.save
#       #   return { contactus: contact }
#       # end

#       # return FieldError.error(contact.errors.full_messages)
#     end
#   end
# end

# class Mutations::CreateContactUs < Mutations::BaseMutation
#   argument :email, String, required: true
#   argument :first_name, String, required: false
#   argument :last_name, String, required: false
#   argument :message, String, required: true

#   field :contactus, Types::ContactUsType
#   field :errors, [String], null: false

#   def resolve(email:, first_name:, last_name:, message:)
#     contact = ContactUs.new(
#       email: email,
#       first_name: first_name,
#       last_name: last_name,
#       message: message
#     )
#     return FieldError.error(contact.errors.full_messages) unless contact.save

#     { contactus: contact }
#   end
# end

# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_auth, Types::AuthType, mutation: Mutations::AuthMutation
    field :create_contact_us, Types::ContactUsType, mutation: Mutations::CreateContactUs
    # field :create_contact_us, mutation: Mutations::CreateContactUs
  end
end

# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    field :entries, [Types::EntryType], null: false
    field :current_appointments, [Types::AppointmentType], null: false
    field :appointments, [Types::AppointmentType], null: false do
      argument :filter, Types::FilterInput, required: false
    end
    field :sessions, [Types::SessionType], null: false

    def users
      User.all
    end

    def entries
      context[:current_user]&.entries&.with_attached_image || []
    end

    # def appointments(filter: {})
    #   context[:current_user]&.patient_appointments || []
    # end

    def appointments(filter: {})
      appointments = context[:current_user]&.patient_appointments || []

      if filter.present?
        appointments = apply_filters(appointments, filter)
      end

      appointments
    end

    def current_appointments
      context[:current_user]&.patient_appointments&.current_and_future || []
    end

    def sessions
      context[:current_user]&.sessions.order(:date) || []
    end

    private

    def apply_filters(appointments, filter)
      if filter[:status].present?
        appointments = appointments.where(status: filter[:status].to_sym)
      end

      appointments
    end
  end
end

# frozen_string_literal: true

# QueryType = GraphQL::ObjectType.define do
#   name "Query"
#   description "The query root of this schema. See available queries."

#   field :users, types[UserType] do
#     description 'Fetch an array of treatment plans and recommended products from Fullscript given a user id'
#     resolve ->(object, args, ctx){
#       return [] unless ctx[:current_user]
#       User.all
#     }
#   end
# end
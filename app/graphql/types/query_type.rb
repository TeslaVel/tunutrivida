# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: false
    field :entries, [Types::EntryType], null: false do
      argument :order, String, required: false
    end
    field :current_appointments, [Types::AppointmentType], null: false
    field :appointments, Types::PaginatedAppointmentType, null: false do
      argument :filter, Types::FilterInput, required: false
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end
    field :sessions, Types::PaginatedSessionType, null: false do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end
    field :conversation, Types::ConversationType, null: true
    field :session_data_chart, Types::SessionDataChartType, null: true
    field :dietitian, Types::DietitianType, null: true
    field :profile, Types::ProfileType, null: true

    def users
      User.all
    end

    def entries(order: nil)
      if order.present?
        entries = context[:current_user]&.entries&.with_attached_image&.order(created_at: :desc) || []
      else
        entries = context[:current_user]&.entries&.with_attached_image || []
      end

      entries
    end

    def appointments(filter: {}, page: 1, limit: 7)
      if filter[:status].present?

        if filter[:status] == 'pending'
          appointments = context[:current_user]&.patient_appointments&.current_and_future || []
        else
          appointments = context[:current_user]&.patient_appointments&.where(status: filter[:status].to_sym) || []
        end
      else
        appointments = context[:current_user]&.patient_appointments || []
      end


      appointments = appointments.page(page).per(limit)

      return {
        paginated: appointments,
        page: page,
        limit: limit,
        next_page: appointments.next_page,
        prev_page: appointments.prev_page,
        current_page: appointments.current_page,
        total_pages: appointments.total_pages
      }
    end

    def current_appointments
      context[:current_user]&.patient_appointments&.current_and_future || []
    end

    def sessions(page: 1, limit: 7)
      sessions = context[:current_user]&.sessions&.order(date: :desc)

      return Session.none unless sessions.present?

      sessions = sessions.page(page).per(limit)

      return {
        paginated: sessions,
        page: page,
        limit: limit,
        next_page: sessions.next_page,
        prev_page: sessions.prev_page,
        current_page: sessions.current_page,
        total_pages: sessions.total_pages
      }
    end

    def conversation
      context[:current_user]&.patient_conversation
    end

    def session_data_chart
      return unless context[:current_user].present?

      patient = context[:current_user]

      sessions = [patient.sessions.first] | (patient&.sessions&.date_asc.last(9) || [])
      days = sessions.map { |sess| sess.date.to_date.strftime('%d-%m-%Y') }

      return {
        days: days,
        imc: sessions.map(&:imc).compact,
        weight: sessions.map(&:weight).compact,
        body_grease: sessions.map(&:body_grease).compact,
        muscle_mass: sessions.map(&:muscle_mass).compact
      }
    end

    def dietitian
      context[:current_user]&.dietitian
    end

    def profile
      context[:current_user]
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
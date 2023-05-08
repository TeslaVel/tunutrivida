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

    def users
      User.all
    end

    def entries
      Entry.all
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
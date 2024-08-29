# frozen_string_literal: true

module Types
  class NoteType < Types::BaseObject
    field :id, String
    field :message, String
    field :created_at, String
    field :conversation_id, String
    field :user, UserType


    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def user
      if object.is_a?(Hash)
        object[:user]
      else
        object.user
      end
    end
  end
end

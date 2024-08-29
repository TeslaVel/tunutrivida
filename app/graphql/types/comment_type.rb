# frozen_string_literal: true

module Types
  class CommentType < BaseObject
    field :id, String
    field :message, String
    field :entry_id, String
    field :user_id, String
    field :comment_type, Int
    field :created_at, String
    field :user, UserType

    def user
      if object.is_a?(Hash)
        object[:user]
      else
        object.user
      end
    end

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%b %-d at %I:%H %P')
      else
        object.created_at.strftime('%b %-d at %I:%H %P')
      end
    end
  end
end

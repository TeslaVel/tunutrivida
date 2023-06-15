module Types
  class EntryType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :entry_type, String, null: false
    field :image_url, String, null: true
    field :created_at, String
    field :comments, [CommentType], null: true
    field :user, UserType, null: true

    def image_url
      return unless object.image.attached?

      Rails.application.routes.url_helpers.rails_blob_url(object.image).strip
    end

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def comments
      object.comments.includes(:user)
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

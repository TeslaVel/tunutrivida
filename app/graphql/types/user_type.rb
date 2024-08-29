# frozen_string_literal: true

module Types
  class UserType < BaseObject
    field :id, String
    field :first_name, String
    field :last_name, String
    field :email, String
    field :username, String
    field :full_name, String
    field :first_name_initial, String
    field :initials, String
    field :image_url, String, null: true

    def image_url
      return unless object.image.attached?

      Rails.application.routes.url_helpers.rails_blob_url(object.image).strip
    end

    def full_name
      object.full_name
    end

    def first_name_initial
      object.first_name_initial
    end

    def initials
      object.get_initials
    end
  end
end

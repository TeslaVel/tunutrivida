# frozen_string_literal: true

module Types
  class ProfileType < BaseObject
    field :id, String
    field :first_name, String
    field :last_name, String
    field :email, String
    field :dietitian_id, String
    field :username, String
    field :full_name, String
    field :first_name_initial, String
    field :initials, String
    field :image_url, String, null: true
    field :height, String, null: true
    field :weight, String, null: true
    field :imc, String, null: true
    field :age, String, null: true
    field :gender, String, null: true

    def height
      return unless object.sessions.any?

      object.sessions.first.height
    end

    def weight
      return unless object.sessions.any?

      object.sessions.first.weight
    end

    def imc
      return unless object.sessions.any?

      object.sessions.first&.imc
    end

    def gender
      return unless object.gender

      object.gender.name.downcase
    end

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

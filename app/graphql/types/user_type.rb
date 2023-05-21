# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :username, String, null: false
    field :full_name, String, null: false
    field :first_name_initial, String, null: false
    field :initials, String, null: false

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

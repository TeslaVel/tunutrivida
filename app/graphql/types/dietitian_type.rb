# frozen_string_literal: true

module Types
  class DietitianType < BaseObject
    field :id, String
    field :first_name, String
    field :last_name, String
    field :email, String
    field :username, String
    field :full_name, String
    field :first_name_initial, String
    field :initials, String

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

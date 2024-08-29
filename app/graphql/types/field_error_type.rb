# frozen_string_literal: true

module Types
  class FieldErrorType < Types::BaseObject
    field :field, String, null: true
    field :message, String, null: false
    # Otros campos de tipo que desees agregar
  end
end
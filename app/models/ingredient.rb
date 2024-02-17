# frozen_string_literal: true

# Ingredient
class Ingredient < ApplicationRecord
  has_many :restricted_ingredient_conditions

  INGREDIENT_TYPES = %i[
    simple
    compound
  ].freeze

  enum ingredient_type: INGREDIENT_TYPES
end

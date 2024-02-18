# frozen_string_literal: true

# Meal
class Meal < ApplicationRecord
  has_many :restricted_ingredient_conditions

  MEAL_TYPES = %i[
    simple
    compound
  ].freeze

  TYPE_OF_USES = %i[
    breakfast
    lunch
    dinner
  ].freeze

  enum meal_type: MEAL_TYPES
  enum type_of_use: TYPE_OF_USES

  paginates_per 10
end

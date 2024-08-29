# frozen_string_literal: true

# DietMealTime
class DietMealTime < ApplicationRecord
  belongs_to :diet_meal_week
  has_one :diet_ingredient, dependent: :destroy

  accepts_nested_attributes_for :diet_ingredient, allow_destroy: true

  DIET_MEAL_TIMES = %i[
    breakfast
    lunch
    dinner
  ].freeze

  enum meal_time: DIET_MEAL_TIMES
end

# frozen_string_literal: true

# DietMealTime
class DietMealTime < ApplicationRecord
  belongs_to :diet_meal_week
  has_many :diet_ingredients, dependent: :destroy

  accepts_nested_attributes_for :diet_ingredients, allow_destroy: true

  DIET_MEAL_TIMES = %i[
    breakfast
    lunch
    dinner
  ].freeze

  enum meal_time: DIET_MEAL_TIMES
end

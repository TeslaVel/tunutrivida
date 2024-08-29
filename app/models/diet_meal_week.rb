# frozen_string_literal: true

# DietMealTime
class DietMealWeek < ApplicationRecord
  belongs_to :diet
  has_many :diet_meal_times, dependent: :destroy

  accepts_nested_attributes_for :diet_meal_times, allow_destroy: true

  DAYS_OF_WEEK = %i[
    sunday
    monday
    tuesday
    wednesday
    thursday
    friday
    saturday
  ].freeze

  enum day_of_week: DAYS_OF_WEEK
end

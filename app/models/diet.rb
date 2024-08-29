# frozen_string_literal: true

# Diet
class Diet < ApplicationRecord
  has_many :diet_meal_weeks, dependent: :destroy
  has_many :diet_meal_times, through: :diet_meal_weeks
  has_many :diet_ingredients, through: :diet_meal_times
  has_many :meals, through: :diet_ingredients
  belongs_to :dietitian, class_name: 'User', foreign_key: 'dietitian_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :session, optional: true

  accepts_nested_attributes_for :diet_meal_weeks, allow_destroy: true

  paginates_per 6

end

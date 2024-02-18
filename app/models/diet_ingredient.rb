# frozen_string_literal: true

# DietIngredient
class DietIngredient < ApplicationRecord
  belongs_to :diet_meal_time
  belongs_to :meal
end

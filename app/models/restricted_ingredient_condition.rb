# frozen_string_literal: true

# RestrictedIngredientCondition
class RestrictedIngredientCondition < ApplicationRecord
  belongs_to :meal
  belongs_to :condition

  validates :meal_id, uniqueness: { scope: :condition_id }
end

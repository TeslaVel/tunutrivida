# frozen_string_literal: true

# RestrictedIngredientCondition
class RestrictedIngredientCondition < ApplicationRecord
  belongs_to :ingredient
  belongs_to :condition
end

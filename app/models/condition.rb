# frozen_string_literal: true

# Condition
class Condition < ApplicationRecord
  has_many :restricted_ingredient_conditions
  has_many :restricted_ingredients, through: :restricted_ingredient_conditions, source: :meal

  paginates_per 7
end

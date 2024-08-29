# frozen_string_literal: true

module Elements
  # Elements::DietComponent
  class DietComponent < ApplicationComponent
    def initialize(diet:)
      super
      @diet = diet
    end

    def render?
      @diet&.diet_meal_weeks&.present?
    end

    def body_data
      @diet_body = @diet.diet_meal_weeks.includes(:diet_meal_times).group_by(&:day_of_week)
      @diet_body.transform_values! do |dmws|
        dmws.each_with_object({}) do |dmw, hash|
          dmw.diet_meal_times.each do |dmt|
            hash[dmt.meal_time] = {
              meal_time: dmt.meal_time,
              meal_name: dmt.diet_ingredient.meal.name,
              instructions: dmt.diet_ingredient.instructions
            }
          end
        end
      end
    end

    private

    attr_reader :diet_body
  end
end

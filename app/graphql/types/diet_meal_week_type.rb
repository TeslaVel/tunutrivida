module Types
  class DietMealWeekType < BaseObject
    field :id, String
    field :diet_id, String
    field :day_of_week, String
    field :created_at, String
    field :diet_meal_times, [DietMealTimeType]

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def diet_meal_times
      if object.is_a?(Hash)
        object[:diet_meal_times]
      else
        object.diet_meal_times
      end
    end
  end
end

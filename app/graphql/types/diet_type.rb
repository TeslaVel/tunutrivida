module Types
  class DietType < BaseObject
    field :id, String
    field :name, String
    field :description, String
    field :dietitian_id, String
    field :patient_id, String
    field :session_id, String
    field :diet_meal_weeks, [Types::DietMealWeekType]
    field :created_at, String

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def diet_meal_weeks
      if object.is_a?(Hash)
        object[:diet_meal_weeks]
      else
        object.diet_meal_weeks
      end
    end
  end
end

module Types
  class DietMealTimeType < BaseObject
    field :id, String
    field :diet_meal_week_id, String
    field :meal_time, String
    field :created_at, String
    field :diet_ingredient, DietIngredientType

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def diet_ingredient
      if object.is_a?(Hash)
        object[:diet_ingredient]
      else
        object.diet_ingredient
      end
    end
  end
end

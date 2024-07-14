module Types
  class DietIngredientType < BaseObject
    field :id, String
    field :diet_meal_time_id, String
    field :meal_id, String
    field :instructions, String
    field :created_at, String
    field :meal, MealType, null: true

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def meal
      if object.is_a?(Hash)
        object[:meal]
      else
        object.meal
      end
    end
  end
end

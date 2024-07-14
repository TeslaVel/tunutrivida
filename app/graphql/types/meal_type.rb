module Types
  class MealType < BaseObject
    field :id, String
    field :name, String
    field :type_of_use, String
    field :meal_type, String
    field :description, String
    field :created_at, String

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end
  end
end

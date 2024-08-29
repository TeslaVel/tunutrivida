module Types
  class SessionType < BaseObject
    field :id, ID
    field :initial, Boolean
    field :age, String
    field :date, String
    field :dietitian, DietitianType
    field :height, String
    field :weight, String
    field :waist, String
    field :hip, String
    field :high_abdomen, String
    field :low_abdomen, String
    field :imc, String
    field :ideal_weight, String
    field :body_grease, String
    field :visceral_grease, String
    field :muscle_mass, String
    field :bone_mass, String
    field :water_percentage, String
    field :bmr, String
    field :metabolic_age, String
    field :physical_complexion, String
    field :activity_factor, ActivityFactorType
    field :diet, DietType, null: true

    def age
      object.patient.age
    end

    def date
      if object.is_a?(Hash)
        object[:date].strftime('%Y-%m-%d %I:%H %P')
      else
        object.date.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def dietitian
      if object.is_a?(Hash)
        object[:dietitian]
      else
        object.dietitian
      end
    end

    def activity_factor
      if object.is_a?(Hash)
        object[:activity_factor]
      else
        object.activity_factor
      end
    end

    def diet
      if object.is_a?(Hash)
        object[:diet]
      else
        object.diet
      end
    end
  end
end

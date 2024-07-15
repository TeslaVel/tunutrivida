module Types
  class ConversationType < BaseObject
    field :id, ID
    field :dietitian, DietitianType
    field :patient, UserType
    field :created_at, String
    field :notes, [NoteType]

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%Y-%m-%d %I:%H %P')
      else
        object.created_at.strftime('%Y-%m-%d %I:%H %P')
      end
    end

    def dietitian
      if object.is_a?(Hash)
        object[:dietitian]
      else
        object.dietitian
      end
    end

    def patient
      if object.is_a?(Hash)
        object[:patient]
      else
        object.patient
      end
    end
  end
end

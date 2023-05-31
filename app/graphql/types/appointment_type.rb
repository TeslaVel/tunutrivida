module Types
  class AppointmentType < BaseObject
    field :id, ID
    field :title, String
    field :created_at, String
    field :start_date, String
    field :time_start, String
    field :time_end, String
    field :dietitian, UserType
    field :status, String
    field :appointment_type, String

    def created_at
      if object.is_a?(Hash)
        object[:created_at].strftime('%d-%m-%Y %I:%H %P')
      else
        object.created_at.strftime('%d-%m-%Y %I:%H %P')
      end
    end

    def time_start
      if object.is_a?(Hash)
        object[:time_start].strftime('%d-%m-%Y %I:%H %P') # strftime('%I:%H %P')
      else
        object.time_start.strftime('%d-%m-%Y %I:%H %P') # strftime('%I:%H %P')
      end
    end

    def time_end
      if object.is_a?(Hash)
        object[:time_end].strftime('%d-%m-%Y %I:%H %P') # strftime('%I:%H %P')
      else
        object.time_end.strftime('%d-%m-%Y %I:%H %P') # strftime('%I:%H %P')
      end
    end

    def start_date
      if object.is_a?(Hash)
        object[:start_date].strftime('%d-%m-%Y %I:%H %P')
      else
        object.start_date.strftime('%d-%m-%Y %I:%H %P')
      end
    end

    def dietitian
      if object.is_a?(Hash)
        object[:dietitian]
      else
        object.dietitian
      end
    end
  end
end

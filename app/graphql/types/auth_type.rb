module Types
  class AuthType < BaseObject
    field :id, String
    field :email, String
    field :token, String
    field :first_name, String
    field :last_name, String
    field :full_name, String
    field :initials, String
    field :dietitian_id, String
    field :image_url, String, null: true
    field :height, String
    field :weight, String
    field :imc, String
    field :age, String
    field :gender, String

    def token
      JwtService.encode({ user_id: object.id })
    end

    def initials
      object.get_initials
    end

    def height
      if object.is_a?(Hash)
        object[:sessions]&.first&.height
      else
        object.sessions&.first&.height
      end
    end

    def weight
      if object.is_a?(Hash)
        object[:sessions]&.first&.weight
      else
        object.sessions&.first&.weight
      end
    end

    def gender
      if object.is_a?(Hash)
        object[:gender]&.height&.downcase
      else
        object.gender&.name&.downcase
      end
    end

    def age
      object.age
    end

    def imc
      if object.is_a?(Hash)
        object[:sessions]&.first&.imc
      else
        object.sessions&.first&.imc
      end
    end
  end
end

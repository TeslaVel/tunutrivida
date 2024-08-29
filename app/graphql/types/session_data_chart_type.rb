module Types
  class SessionDataChartType < BaseObject
    field :days, [String], null: false
    field :imc, [String], null: false
    field :weight, [String], null: false
    field :body_grease, [String], null: false
    field :muscle_mass, [String], null: false
  end
end

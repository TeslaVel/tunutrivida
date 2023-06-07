module Types
  class OrderByInput < Types::BaseInputObject
    argument :order, String, required: false
    # Otros argumentos de filtro que desees agregar
  end
end

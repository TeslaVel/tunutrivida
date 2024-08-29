module Types
  class FilterInput < Types::BaseInputObject
    argument :status, String, required: false
    # Otros argumentos de filtro que desees agregar
  end
end

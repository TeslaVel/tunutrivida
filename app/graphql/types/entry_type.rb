module Types
  class EntryType < BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :entry_type, String, null: false
  end
end

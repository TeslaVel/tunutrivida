module Types
  class PaginatedSessionType < BaseObject
    field :paginated, [Types::SessionType]
    field :page, Integer
    field :limit, Integer
    field :next_page, Integer
    field :prev_page, Integer
    field :current_page, Integer
    field :total_pages, Integer
  end
end

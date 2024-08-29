# frozen_string_literal: true

# PaginatorComponent
module Pagination
  # Pagination::PaginateComponent
  class PaginateComponent < ViewComponent::Base
    def initialize(collection:, filters: [], searchers: [])
      @collection = collection
      @table_alias = @collection.model.name.to_s.downcase
      @filters = filters
      @searchers = searchers
    end

    private

    attr_reader :table_alias, :collection

    def render?
      @collection.total_pages > 1
    end

    def first?
      @collection.current_page == 1
    end

    def last?
      @collection.current_page == @collection.total_pages
    end

    def last_page
      @collection.total_pages
    end

    def previous_page
      @collection.current_page - 1
    end

    def next_page
      @collection.current_page + 1
    end

    def pages
      (1..@collection.total_pages).to_a
    end
  end
end

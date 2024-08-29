# frozen_string_literal: true

# PaginatorComponent
module Pagination
  # Pagination::PaginatorComponent
  class PaginatorComponent < ViewComponent::Base
    def initialize(
      collection:,
      filter_url:,
      filter_options: { options: [] },
      searcher_options: { options: [] },
      filter_button_text: 'Apply'
    )
      super
      @collection = collection
      @filter_url = filter_url
      @filter_options = filter_options
      @searcher_options = searcher_options
      @filter_button_text = filter_button_text
    end

    def build_filter(option)
      return '' unless option[:name].present?

      is_collection = option[:type] == 'collection'

      render(
        Filters::FilterSelectComponent.new(
          type: option[:type],
          rows: is_collection ? option[:name].classify.constantize.all : option[:rows] || [],
          filter_id: "#{option[:name]}_filter",
          input_class: @filter_options[:input_class]
        )
      )
    end

    def build_searcher(option)
      render(
        Filters::FilterFieldComponent.new(
          filter_id: "#{option[:name]}_filter",
          type: option[:type],
          parent_class: @searcher_options[:parent_class],
          input_class: @searcher_options[:input_class],
          place_holder: option[:place_holder]
        )
      )
    end

    private

    attr_reader :table_alias, :collection, :filter_options, :searcher_options, :filter_url, :filter_button_text
  end
end

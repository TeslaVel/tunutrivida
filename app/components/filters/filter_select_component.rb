# frozen_string_literal: true

module Filters
  # Filters::FilterSelectComponent
  class FilterSelectComponent < ApplicationComponent
    def initialize(rows:, type:, input_class:, filter_id: 'filter_select_component')
      super
      @rows = rows
      @filter_id = filter_id
      @type = type
      @input_class = input_class
    end

    private

    attr_reader :rows, :filter_id, :type, :input_class
  end
end

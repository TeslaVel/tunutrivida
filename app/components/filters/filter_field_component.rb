# frozen_string_literal: true

module Filters
  # Filters::FilterFieldComponent
  class FilterFieldComponent < ApplicationComponent
    def initialize(filter_id:, type: 'text', place_holder: 'Search', parent_class: '', input_class: '')
      super
      @filter_id = filter_id
      @type = type
      @parent_class = parent_class
      @input_class = input_class
      @place_holder = place_holder
    end

    private

    attr_reader :filter_id, :type, :parent_class, :input_class, :place_holder
  end
end

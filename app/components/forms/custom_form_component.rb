# frozen_string_literal: true

module Forms
  # Forms::CustomComponent
  class CustomFormComponent < ApplicationComponent
    attr_reader :scope_instance, :url, :data_type, :html_options, :fields, :is_row

    HTML_OPTONS = {
      multipart: true,
      remote: true
    }.freeze

    def initialize(
      scope_instance:,
      url:,
      html_options:,
      data_type: {
        type: :json
      },
      fields: nil,
      is_row: false
    )
      super
      @scope_instance = scope_instance
      @url = url
      @data_type = data_type
      @fields = fields
      @is_row = is_row
      @html_options = {**HTML_OPTONS, **html_options}
    end
  end
end

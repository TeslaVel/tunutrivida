# frozen_string_literal: true

module Forms
  # Forms::CustomComponent
  class CustomFormComponent < ApplicationComponent
    attr_reader :scope_instance, :url, :data_type, :html_options, :fields

    HTML_OPTONS = {
      multipart: true,
      remote: true
    }.freeze

    def initialize(
      scope_instance:,
      url:,
      data_type: {
        type: :json
      },
      html_options:,
      fields: nil
    )
      super
      @scope_instance = scope_instance
      @url = url
      @data_type = data_type
      @fields = fields
      @html_options = HTML_OPTONS.merge(html_options)
    end
  end
end

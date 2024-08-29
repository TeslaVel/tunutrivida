# frozen_string_literal: true

module Elements
  # Elements::TableShowComponent
  class TableShowComponent < ApplicationComponent
    ULR_HELPER = Rails.application.routes.url_helpers

    def initialize(
      row_fields:,
      row_object:,
      table_alias:,
      table_component_id: 'table_component',
      table_class: ''
    )
      super
      @row_fields = row_fields
      @row_object = row_object
      @table_alias = table_alias
      @table_class = table_class
      @table_component_id = table_component_id
    end

    private

    attr_reader :row_fields, :table_class, :table_component_id

    def build_header_fields(option)
      case option[:field]
      when Symbol
        {
          field: option[:label].present? ? option[:label] : option[:field],
          width: option[:width].present? ? option[:width] : '',
          classes: ''
        }
      when String
        {
          field: option[:label].present? ? option[:label] : option[:field],
          width: option[:width].present? ? option[:width] : '',
          classes: ''
        }
      else
        {
          field: 'Invalid field',
          width: option[:width].present? ? option[:width] : '',
          classes: 'c-red'
        }
      end
    end

    def render_header(option)
      head = build_header_fields(option)
      content_tag(:th, t(head[:field].downcase), width: head[:width], class: head[:classes])
    end

    def render_header_and_row(option)
      render_header(option) + render_row(option)
    end

    def render_row(option)
      classes = option[:classes].present? ? option[:classes] : ''

      case option[:field]
      when Symbol
        render_value_or_link(option, classes)
      when String
        render_custom_field(option, classes)
      else
        raise ArgumentError, "Invalid field type: #{option[:field].class}"
      end
    end

    def render_value_or_link(option, classes)
      content = 'no field'

      content = option[:value] if option[:value].present?
      content = option[:element].call(row) if option[:element].present?

      if option[:field].present? && option[:value].nil? && option[:element].nil?
        content = @row_object[option[:field]]
        content = option[:link].call(content, @row_object) if option[:link].present?
      end

      content_tag(:td, content, class: classes)
    end

    def render_custom_field(option, classes)
      content = 'No field'

      content = option[:element].call(@row_object) if option[:element].present?
      content = option[:value] if option[:value].present?

      if option[:field].present? && option[:value].nil? && option[:element].nil?
        parts = option[:field].strip.split('.')
        value = @row_object.public_send(parts[0])&.try(parts[1])

        content = value
        content = option[:link].call(content, @row_object) if option[:link].present?
      end

      content_tag(:td, content, class: classes)
    end
  end
end

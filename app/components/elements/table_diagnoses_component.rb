# frozen_string_literal: true

module Elements
  # Elements::TableDiagnosesComponent
  class TableDiagnosesComponent < ApplicationComponent
    ULR_HELPER = Rails.application.routes.url_helpers

    def initialize(
      row_fields:,
      row_objects:,
      table_alias:,
      row_actions: nil,
      table_class: '',
      title: '',
      selected_row: nil
    )
      super
      @row_fields = row_fields
      @row_objects = row_objects
      @selected_row = selected_row
      @table_alias = table_alias
      @header_fields = get_header_fields
      @table_class = table_class
      @title = title
    end

    private

    attr_reader :header_fields, :row_objects, :table_class

    def get_header_fields
      @row_fields.map do |option|
        case option[:field]
        when Symbol
          {
            field: option[:label].present? ? option[:label] : option[:field],
            width: option[:width].present? ? option[:width] : '',
            classes: option[:classes].present? ? option[:classes] : 'text-center'
          }
        when String
          {
            field: option[:label].present? ? option[:label] : option[:field],
            width: option[:width].present? ? option[:width] : '',
            classes: option[:classes].present? ? option[:classes] : 'text-center'
          }
        else
          {
            field: 'Invalid field',
            width: option[:width].present? ? option[:width] : '',
            classes: ''
          }
        end
      end
    end

    def render_header(head)
      # content_tag(:th, head[:field], class: 'text-center')
      content_tag(:th, t(head[:field]), class: head[:classes], width: head[:width])
    end

    def render_row(row)
      content_tag(:tr, class: "#{ @selected_row&.id == row.id ? "diagonis_#{@title.downcase}" : ''}") do
        @row_fields.map do |field_option|
          concat(content_tag(:td, row[field_option[:field]], class: 'text-center'))
        end
      end
    end

    # def render_value_or_link(row, option)
    #   return content_tag(:td, option[:link].call(row)) if option[:link].present?

    #   content_tag(:td, row[option[:field]])
    # end

    # def render_custom_field(row, field)
    #   parts = field.split('.')
    #   value = row.public_send(parts[0])&.try(parts[1]) # Handle potential nil association
    #   content_tag(:td, value || '-') # Display '-' if value is nil
    # end
  end
end

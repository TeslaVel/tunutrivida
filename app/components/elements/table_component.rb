# frozen_string_literal: true

module Elements
  # Elements::TableComponent
  class TableComponent < ApplicationComponent
    ULR_HELPER = Rails.application.routes.url_helpers

    def initialize(row_fields:, row_objects:, table_alias:, row_actions: nil)
      super
      @row_fields = row_fields
      @row_objects = row_objects
      @table_alias = table_alias
      @row_actions = row_actions.present? ? { **ROW_ACTIONS, **row_actions } : ROW_ACTIONS
      @header_fields = get_header_fields
    end

    private

    attr_reader :header_fields, :row_objects

    ROW_ACTIONS = {
      show: { with_icon: { name: 'eye' }, color_class: 'c-blue', label: 'Show' },
      edit: { with_icon: { name: 'edit' }, color_class: 'c-green', label: 'Edit' },
      delete: {
        with_icon: { name: 'trash' },
        color_class: 'c-blue',
        method: :delete,
        label: 'Delete',
        data: { confirm: 'Are you sure?' }
      }
    }.freeze

    def get_header_fields
      @row_fields.map do |field_option|
        case field_option[:field]
        when Symbol
          field_option[:field].to_s.titleize
        when String
          field_option[:label].present? ? field_option[:label].titleize : '-'
        else
          'Invalid field'
        end
      end
    end

    def render_row(row)
      content_tag(:tr) do
        @row_fields.map do |field_option|
          case field_option[:field]
          when Symbol
            render_value_or_link(row, field_option)
          when String
            render_custom_field(row, field_option[:field])
          else
            raise ArgumentError, "Invalid field type: #{field_option[:field].class}"
          end
        end.join('').html_safe + render_actions(row)
      end
    end

    def render_value_or_link(row, option)
      return content_tag(:td, option[:link].call(row)) if option[:link].present?

      content_tag(:td, row[option[:field]])
    end

    def render_custom_field(row, field)
      parts = field.split('.')
      value = row.public_send(parts[0])&.try(parts[1]) # Handle potential nil association
      content_tag(:td, value || '-') # Display '-' if value is nil
    end

    def render_actions(row)
      content_tag(:td, class: 'd-flex justify-content-around') do
        actions = []

        if @row_actions[:show].present?
          actions << render_action(@row_actions[:show], row, 'show')
        end

        if @row_actions[:edit].present?
          actions << render_action(@row_actions[:edit], row, 'edit')
        end

        if @row_actions[:delete].present?
          actions << render_action(@row_actions[:delete], row, 'delete')
        end

        safe_join(actions, ' ')
      end
    end

    def render_action(action, row, type)
      color_class = action[:color_class]

      initial_path = type == 'edit' ? 'edit_' : ''
      url = ULR_HELPER.send("#{initial_path}#{@table_alias}_path", row)
      label = action[:label]
      other_options = {
        class: "px-1 #{color_class}"
      }

      text_link = label
      if action[:with_icon].present?
        name = action[:with_icon][:name]
        text_link = (render Elements::IconHandlerComponent.new(name:, color: color_class))
      end

      if action[:method].present?
        other_options = {
          **other_options,
          method: action[:method].to_sym,
          data: action[:data].present? ? action[:data] : {}
        }
      end

      content_tag(:span, link_to(text_link, url, **other_options))
    end
  end
end

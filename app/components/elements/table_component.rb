# frozen_string_literal: true

module Elements
  # Elements::TableComponent
  class TableComponent < ApplicationComponent
    ULR_HELPER = Rails.application.routes.url_helpers
    ROW_ACTIONS = {
      render: true,
      show: { with_icon: { name: 'eye', width: '18' }, classes: 'c-blue', label: 'Show' },
      edit: { with_icon: { name: 'edit', width: '14' }, classes: 'c-green', label: 'Edit' },
      delete: {
        with_icon: { name: 'trash', width: '14' },
        classes: 'c-red',
        method: :delete,
        label: 'Delete',
        data: { confirm: 'Are you sure?' },
        should_hide: ->(_object) { false }
      }
    }.freeze

    def initialize(
      row_fields:,
      row_objects:,
      table_alias:,
      row_actions: {},
      table_component_id: 'table_component',
      table_class: ''
    )
      super
      @row_fields = row_fields
      @row_objects = row_objects
      @table_alias = table_alias
      @row_actions = { render: row_actions.key?(:render) ? row_actions[:render] : ROW_ACTIONS[:render] }
      @row_actions[:show] = row_actions.key?(:show) ? (row_actions[:show].present? ? { **ROW_ACTIONS[:show], **row_actions[:show]} : nil) : ROW_ACTIONS[:show]
      @row_actions[:edit] = row_actions.key?(:edit) ? (row_actions[:edit].present? ? { **ROW_ACTIONS[:edit], **row_actions[:edit]} : nil ) : ROW_ACTIONS[:edit]
      @row_actions[:delete] = row_actions.key?(:delete) ? (row_actions[:delete].present? ? { **ROW_ACTIONS[:delete], **row_actions[:delete] } : nil ) : ROW_ACTIONS[:delete]
      @header_fields = build_header_fields
      @table_class = table_class
      @show_colum_actions = @row_actions[:render]
      @table_component_id = table_component_id
    end

    private

    attr_reader :header_fields, :row_objects, :table_class,
                :show_colum_actions, :table_component_id

    def build_header_fields
      @row_fields.map do |option|
        case option[:field]
        when Symbol
          {
            field: option[:label].present? ? option[:label] : option[:field],
            width: option[:width].present? ? option[:width] : '',
            classes: option[:classes].present? ? option[:classes] : ''
          }
        when String
          {
            field: option[:label].present? ? option[:label] : option[:field],
            width: option[:width].present? ? option[:width] : '',
            classes: option[:classes].present? ? option[:classes] : ''
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
      content_tag(:th, t(head[:field].downcase), width: head[:width], classes: head[:classes])
    end

    def render_row(row)
      content_tag(:tr) do
        @row_fields.map do |field_option|
          classes = field_option[:classes].present? ? field_option[:classes] : ''

          case field_option[:field]
          when Symbol
            render_value_or_link(row, field_option, classes)
          when String
            render_custom_field(row, field_option, classes)
          else
            raise ArgumentError, "Invalid field type: #{field_option[:field].class}"
          end
        end.join('').html_safe + render_actions(row)
      end
    end

    def render_value_or_link(row, option, classes)
      content = 'No field'

      content = option[:value] if option[:value].present?
      content = option[:element].call(row) if option[:element].present?

      if option[:field].present? && option[:value].nil? && option[:element].nil?
        content = row[option[:field]]
        content = option[:link].call(content, row) if option[:link].present?
      end

      content_tag(:td, content, class: classes)
    end

    def render_custom_field(row, option, classes)
      content = 'No field'

      content = option[:element].call(row) if option[:element].present?
      content = option[:value] if option[:value].present?

      if option[:field].present? && option[:value].nil? && option[:element].nil?
        parts = option[:field].split('.')
        # complete = "#{parts[0]}#{parts[1].present? ? ".try(#{parts[1]})" : ''}"
        value = row.public_send(parts[0])
        value = parts[1].present? ? value&.try(parts[1]) : value

        content = value || '-'
        content = option[:link].call(content, row) if option[:link].present?
      end

      content_tag(:td, content, class: classes)
    end

    def render_actions(row)
      return unless @row_actions[:render]

      content_tag(:td, class: 'd-flex justify-content-around', width: '') do
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
      return content_tag(:span, "&nbsp;".html_safe, class: 'px-1', style: "display: inline-block; width: 25px;") if action[:should_hide].present? && action[:should_hide].call(row)

      classes = action[:classes]

      initial_path = type == 'edit' ? 'edit_' : ''

      final_path = if action[:custom_path_method].present?
                    action[:custom_path_method].call(row)
                   else
                    ULR_HELPER.send("#{initial_path}#{@table_alias}_path", row)
                   end

      url = final_path

      label = action[:label]
      other_options = { class: classes }

      text_link = label
      if action[:with_icon].present?
        name = action[:with_icon][:name]
        text_link = (render Elements::IconHandlerComponent.new(name:, classes:, size: '25'))
      end

      if action[:method].present?
        other_options = {
          **other_options,
          method: action[:method].to_sym,
          data: action[:data].present? ? action[:data] : {}
        }
      end

      content_tag(:span, link_to(text_link, url, **other_options), class: "")
    end
  end
end

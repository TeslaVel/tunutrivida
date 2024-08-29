# frozen_string_literal: true

module Forms
  # Forms::FormComponent
  class FormComponent < ApplicationComponent
    ULR_HELPER = Rails.application.routes.url_helpers

    HTML_OPTONS = {
      multipart: true,
      remote: true
    }.freeze

    def initialize(
      scope_instance:,
      table_alias: nil,
      fields: nil,
      is_row: false,
      data_type: { type: :json },
      action_buttons: {},
      html_options: {}
    )
      super
      @scope_instance = scope_instance
      @fields = fields
      @is_row = is_row
      @data_type = data_type
      @html_options = {**HTML_OPTONS, **html_options }
      model_name = table_alias.present? ? table_alias : scope_instance.model_name.name.underscore
      @method = :patch
      path = model_name
      new_record = scope_instance.new_record?
      @title = "Editing #{model_name.titleize}"
      update_text = 'Update'
      if new_record
        @method = :post
        path = model_name.pluralize
        update_text = 'Create'
        @title = "New #{model_name.titleize}"
      end
      @url = ULR_HELPER.send("#{path}_path", scope_instance)
      actions = {
        submit: {
          label: update_text
        },
        back: {
          label: 'Back',
          url:  ULR_HELPER.send("#{model_name.pluralize}_path")
        }
      }.freeze
      @action_buttons = {
        submit: action_buttons.key?(:submit) ? (action_buttons[:submit].present? ? { **actions[:submit], **action_buttons[:submit]} : nil) : actions[:submit],
        back: action_buttons.key?(:back) ? (action_buttons[:back].present? ? { **actions[:back], **action_buttons[:back]} : nil) : actions[:back]
      }
    end

    private

    attr_reader :scope_instance, :data_type, :html_options, :fields, :is_row,
                :title, :action_buttons, :method, :url
  end
end

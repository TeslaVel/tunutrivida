# frozen_string_literal: true

module Forms
  module Inputs
    # Forms::Inputs::InputsComponent
    class InputsComponent < ApplicationComponent
      include ApplicationHelper

      def initialize(form:, fields:, is_row:)
        super
        @form = form
        @fields = fields
        @is_row = is_row
      end

      private

      attr_reader :form, :fields, :is_row
    end
  end
end

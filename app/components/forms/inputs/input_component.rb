# frozen_string_literal: true

module Forms
  module Inputs
    # Forms::Inputs::InputComponent
    class InputComponent < ApplicationComponent
      include ApplicationHelper

      def initialize(form, is_row, **attrs)
        super
        @form = form
        @attrs = attrs
        @is_row = is_row
      end

      private

      attr_reader :form, :is_row, :attrs
    end
  end
end

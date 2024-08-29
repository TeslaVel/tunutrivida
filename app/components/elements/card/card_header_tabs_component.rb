# frozen_string_literal: true

module Elements
  module Card
    # Elements::Card::CardHeaderTabsComponent
    class CardHeaderTabsComponent < ApplicationComponent
      def initialize(options:, classes: '', extra_item_options: [])
        super
        @options = options
        @classes = classes
        @extra_item_options = extra_item_options
      end

      private

      attr_reader :options, :classes, :extra_item_options
    end
  end
end

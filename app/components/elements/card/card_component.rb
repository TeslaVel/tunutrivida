# frozen_string_literal: true

module Elements
  module Card
    # Elements::Card::CardComponent
    class CardComponent < ApplicationComponent
      def initialize(
        header_tabs: nil,
        title: nil,
        text_footer: nil,
        card_class: 'p-2',
        card_header_class: 'bg-transparent',
        card_body_class: '',
        card_footer_class: '',
        card_component_id: 'card_component',
        extra_item_options: []
      )
        super
        @header_tabs = header_tabs
        @title = title
        @text_footer = text_footer
        @card_class = card_class
        @card_header_class = card_header_class
        @card_body_class = card_body_class
        @card_footer_class = card_footer_class
        @card_component_id = card_component_id
        @extra_item_options = extra_item_options
      end

      private

      attr_reader :header_tabs, :title, :text_footer, :card_class, :card_header_class,
                  :card_body_class, :card_footer_class, :card_component_id, :extra_item_options
    end
  end
end

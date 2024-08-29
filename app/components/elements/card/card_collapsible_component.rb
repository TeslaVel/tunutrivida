# frozen_string_literal: true

module Elements
  module Card
    # Elements::Card::CardCollapsibleComponent
    class CardCollapsibleComponent < ApplicationComponent
      def initialize(
        collapsible_key:,
        collapsed: false,
        header_tabs: nil,
        sub_header: nil,
        title_object: nil,
        text_footer: nil,
        card_body_class: '',
        card_body_style: '',
        card_header_class: 'bg-transparent',
        card_classes: '',
        card_footer_class: '',
        card_collapsible_component_id: 'card-component'
      )
        super
        @collapsible_key = collapsible_key
        @collapsed = collapsed
        @header_tabs = header_tabs
        @sub_header = sub_header
        @title_object = title_object
        @text_footer = text_footer
        @card_header_class = card_header_class
        @card_body_class = card_body_class
        @card_body_style = card_body_style
        @card_classes = card_classes
        @card_footer_class = card_footer_class
        @card_collapsible_component_id = card_collapsible_component_id
      end

      private

      attr_reader :collapsible_key, :collapsed, :header_tabs, :sub_header, :title_object, :text_footer,
                  :card_header_class, :card_body_class, :card_body_style, :card_classes, :card_footer_class,
                  :card_collapsible_component_id
    end
  end
end

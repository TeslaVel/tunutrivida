# frozen_string_literal: true

module Elements
  # Elements::CollapsibleLinkComponent
  class CollapsibleLinkComponent < ApplicationComponent
    def initialize(
      copllapsible_key:,
      collapsed: false,
      title: nil,
      classes: ''
    )
      super
      @copllapsible_key = copllapsible_key
      @collapsed = collapsed
      @title = title
      @classes = classes
    end

    private

    attr_reader :copllapsible_key, :collapsed, :title, :classes
  end
end

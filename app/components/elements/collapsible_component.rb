# frozen_string_literal: true

module Elements
  # Elements::CollapsibleComponent
  class CollapsibleComponent < ApplicationComponent
    def initialize(
      copllapsible_key:,
      collapsed: false
    )
      super
      @copllapsible_key = copllapsible_key
      @collapsed = collapsed
    end

    private

    attr_reader :copllapsible_key, :collapsed
  end
end

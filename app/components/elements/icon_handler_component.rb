# frozen_string_literal: true

module Elements
  # Elements::IconHandlerComponent
  class IconHandlerComponent < ApplicationComponent
    attr_reader :name, :color

    def initialize(name:, color: '')
      super
      @name = name
      @color = color
    end
  end
end

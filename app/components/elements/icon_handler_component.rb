# frozen_string_literal: true

module Elements
  # Elements::IconHandlerComponent
  class IconHandlerComponent < ApplicationComponent

    def initialize(name:, classes: 'text-primary-600', size: '20')
      super
      @name = name
      @classes = classes
      @size = size
    end

    private

    attr_reader :name, :classes, :size
  end
end

# frozen_string_literal: true

module Navigation
  # Navigation::SidebarComponent
  class SidebarBrandComponent < ApplicationComponent
    def initialize(name:)
      @name = name
      super
    end

    private

    attr_reader :name
  end
end
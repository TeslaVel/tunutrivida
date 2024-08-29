# frozen_string_literal: true

module Navigation
  # Navigation::SidebarComponent
  class SidebarNavItemComponent < ApplicationComponent
    include ActiveLinkToHelper
    include TemplateNavHelper

    def initialize(name:, path:)
      @name = name
      @path = path
      super
    end

    private

    attr_reader :name, :path
  end
end

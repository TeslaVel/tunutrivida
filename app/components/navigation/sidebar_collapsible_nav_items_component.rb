# frozen_string_literal: true

module Navigation
  # Navigation::SidebarComponent
  class SidebarCollapsibleNavItemsComponent < ApplicationComponent
    include ActiveLinkToHelper
    include TemplateNavHelper

    def initialize(link_modules:, item_name:, icon:, device:)
      @link_modules = link_modules
      @item_name = item_name
      @device = device
      @icon = icon
      super
    end

    def pluck_column(arr, key)
      arr.map { |hash| hash[key] }
    end

    private

    attr_reader :link_modules, :item_name, :device, :icon
  end
end

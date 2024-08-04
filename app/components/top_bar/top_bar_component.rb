# frozen_string_literal: true

module TopBar
  # TopBar::TopBarComponent
  class TopBarComponent < ApplicationComponent
    attr_reader :current_user, :gbl_configuration

    def initialize(current_user:)
      super
      @current_user = current_user
      @gbl_configuration = GlobalConfiguration.first
    end
  end
end

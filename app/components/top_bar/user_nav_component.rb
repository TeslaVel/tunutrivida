# frozen_string_literal: true

module TopBar
  # TopBar::UserNavComponent
  class UserNavComponent < ApplicationComponent
    attr_reader :current_user

    def initialize(current_user:)
      super
      @current_user = current_user
    end
  end
end

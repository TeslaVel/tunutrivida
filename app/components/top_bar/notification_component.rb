# frozen_string_literal: true

module TopBar
  # TopBar::NotificationsComponent
  class NotificationComponent < ApplicationComponent
    attr_reader :notification

    def initialize(notification:)
      super
      @notification = notification
    end
  end
end

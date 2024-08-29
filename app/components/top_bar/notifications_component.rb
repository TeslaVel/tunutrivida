# frozen_string_literal: true

module TopBar
  # TopBar::NotificationsComponent
  class NotificationsComponent < ApplicationComponent
    attr_reader :notifications

    def initialize(current_user:)
      super
      @notifications = Notification.where(
                                      recipient_id: current_user.id,
                                      seen: false,
                                      notification_type: %i[comment note])
    end
  end
end
